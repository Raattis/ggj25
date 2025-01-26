class_name Cluster
extends RigidBody2D

const POP_1 = preload("res://riku/sfx/pop1.ogg")
const POP_2 = preload("res://riku/sfx/pop2.ogg")

var impulse_magnitude := 300.0
var max_angular_velocity := 30.0
var impulse_cooldown :int= 0
var merge_velocity :float= 3.0
const POKS := preload("res://vesa/poks.tscn")
var kulkee = false
var liiku_napein = false
var liike_nopeus = 500.0
var kierto_nopeus = 10000.0

var o := 0.0

func _win_area_hit(body: RigidBody2D, area: Area2D):
	if body == self:
		_on_body_entered(area)

func _ready():
	o = randf() * 12.0
	if get_tree().get_current_scene().name.find("fly") != -1:
		liiku_napein = true
	GameManager.win_area_hit.connect(_win_area_hit)

func _process(_delta: float):
	if global_position.length() > 10000:
		destroy()
	var view_size = get_viewport_rect().size
	var oo := o
	for child in get_children():
		var dy = sin(Time.get_ticks_msec() / 200.0 + oo)
		var dx = sin(Time.get_ticks_msec() / 190.0 + 50 + oo)
		var ds = sin(Time.get_ticks_msec() / 300.0 + 50 + oo)
		oo += o
		if child is Pääkamera:
			continue
		var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
		renderer.push_bubble(
			(child.global_position - view_size / 2.0 + Vector2(dx, dy)) / view_size.y,
			(child.shape.get_radius() + ds) / view_size.y,
			ankkurit.size() / 3.0
		)

func pop(pop_position: Vector2):
	var effekti = POKS.instantiate()
	get_parent().add_child(effekti)
	effekti.global_position = pop_position
	
	

func _integrate_forces(state: PhysicsDirectBodyState2D):
	if not kulkee:
		return
	if get_child_count() == 0:
		destroy()
		return
	
	var kamera = null
	for c in get_children():
		if c is Pääkamera:
			remove_child(c)
			kamera = c
			
	# liikuta napein, jos flying kohtaus
	if liiku_napein:
		var x = 0.0
		if Input.is_action_pressed("vasen"):
			var multi = 1
			if linear_velocity.x > 0:
				multi = 10
			x = -liike_nopeus * multi
		if Input.is_action_pressed("oikea"):
			var multi = 1
			if linear_velocity.x < 0:
				multi = 5
			x = liike_nopeus * multi
		var y = 0.0
		if Input.is_action_pressed("ylös"):
			var multi = 1
			if linear_velocity.y > 0:
				multi = 10
			y = -liike_nopeus * multi
		if Input.is_action_pressed("alas"):
			var multi = 1
			if linear_velocity.y < 0:
				multi = 5
			y = liike_nopeus * multi
		constant_force = Vector2(x, y)
		
		# Rotate?
		var torkki = 0
		if Input.is_action_pressed("kierräplus"):
			torkki = kierto_nopeus
		if Input.is_action_pressed("kierrämiinus"):
			torkki = -kierto_nopeus
		constant_torque = torkki
		
		
	var center_of_mass_local := Vector2(0,0)
	for child in get_children() as Array[Node2D]:
		center_of_mass_local += child.position
	center_of_mass_local /= get_child_count()
	var center_of_mass_global := to_global(center_of_mass_local)

	if get_child_count() > 1:
		for child in get_children():
			child = child as CollisionShape2D
			var dont_move := false
			var p = child.position
			var candidate_position :Vector2= p + (center_of_mass_local - p).limit_length(merge_velocity)
			var r :float= child.shape.radius
			for b in get_children() as Array[CollisionShape2D]:
				if b == child:
					continue
				var radii :float= r + b.shape.radius
				var radii_sqrd := radii * radii
				var dist_sqrd = (b.position - p).length_squared()
				var new_dist_sqrd = (b.position - candidate_position).length_squared()
				if dist_sqrd <= radii_sqrd and new_dist_sqrd < dist_sqrd:
					# touching, and moving would make these closer
					dont_move = true
					break
			if not dont_move:
				child.position = candidate_position
	
	impulse_cooldown -= 1
	if impulse_cooldown < 0 and state.get_contact_count() > 0:
		var pos := state.get_contact_collider_position(0)
		var obj := state.get_contact_collider_object(0) as StaticBody2D
		if obj and obj.collision_layer == (1<<2):
			var closest: CollisionShape2D = null
			var closest_dist :float= INF
			var closest_pos := Vector2(0,0)
			for child in get_children() as Array[Node2D]:
				var dist := (child.global_position - pos).length_squared()
				if dist < closest_dist:
					closest = child
					closest_dist = dist
					closest_pos = child.global_position
			ripple_delete(closest)
			#var offset := closest_pos - center_of_mass_global
			apply_impulse((closest_pos - center_of_mass_global).normalized() * -impulse_magnitude, closest_pos)
			#apply_torque_impulse(offset
			#angular_velocity = atan2(closest_pos.y - center_of_mass_global.y, closest_pos.x - center_of_mass_global.x)
			angular_velocity = clampf(angular_velocity, -max_angular_velocity, max_angular_velocity)
			impulse_cooldown = 10
	if kamera:
		add_child(kamera)

func destroy():
	for c in get_children():
		if c is Pääkamera:
			remove_child(c)
	for child in get_children() as Array[Node2D]:
		child.queue_free()
	queue_free()

func _on_body_entered(body: Node2D):
	if body as Kala:
		if body.spawn_sydän():
			remove_closest_child(body.position, true)
			if get_child_count() == 2:
				# viimeinen kupla on menossa pois, mut viel laskuissa ja kamera
				destroy()
	var sb = body as StaticBody2D
	if sb and sb.collision_layer & (1<<3) != 0:
		destroy()
	var ab = body as Area2D
	if ab and ab.collision_layer & (1<<4) != 0 and ankkurit.size() > 0:
		get_parent().get_parent().find_child("the kalanen").etippä_toi(self);
		print("Voittoon mentiin ", ankkurit.size(), " ankkurin kanssa.")
		GameManager.anchors_collected += ankkurit.size()
		ankkurit.clear()
		gravity_scale = -1
		GameManager.win_grow = 1.2

func find_closest_spot(pos: Vector2, radius: float) -> Vector2:
	var closest_dist: float = INF
	var closest_pos := Vector2(0,0)
	for child in get_children():
		if child is Pääkamera:
			continue
		var diff = (child.global_position - pos)
		var dist = diff.length_squared()
		if dist < closest_dist:
			closest_dist = dist
			closest_pos = child.global_position - diff.normalized() * ((child.shape as CircleShape2D).radius + radius)
	return closest_pos

func ripple_delete(child: Node2D):
	if not child:
		return
	pop(child.global_position)
	child.queue_free()

func remove_closest_child(pos: Vector2, force: bool = false):
	var closest_dist: float = INF
	var closest_child: CollisionShape2D = null
	for child in get_children():
		if not child is CollisionShape2D:
			continue
		if child.get_index() == 0 and not force:
			continue
		var diff = child.global_position - pos
		var dist = diff.length_squared()
		if dist < closest_dist:
			closest_dist = dist
			closest_child = child
	ripple_delete(closest_child)

func _input(event):
	if event.is_pressed():
		if event.as_text() == "C":
			# cheats
			liiku_napein = true

var ankkurit :Array[Node2D]= []
func add_ankkuri(ankkuri: Node2D) -> bool:
	if ankkuri in ankkurit:
		return false
	ankkurit.append(ankkuri)
	gravity_scale = 1;
	return true
