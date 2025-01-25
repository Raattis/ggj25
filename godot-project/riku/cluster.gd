class_name Cluster
extends RigidBody2D

var impulse_magnitude := 300.0
var max_angular_velocity := 30.0
var impulse_cooldown :int= 0
var merge_velocity :float= 3.0
const POKS = preload("res://vesa/poks.tscn")

func _process(delta: float):
	impulse_cooldown -= delta
	if global_position.length() > 10000:
		queue_free()
	var view_size = get_viewport_rect().size
	for child in get_children() as Array[Node2D]:
		var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
		renderer.push_bubble(
			(child.global_position - view_size / 2.0) / view_size.y,
			child.shape.get_radius() / view_size.y
		)

func pop(pop_position: Vector2):
	var effekti = POKS.instantiate()
	get_parent().add_child(effekti)
	effekti.global_position = pop_position
	

func _integrate_forces(state: PhysicsDirectBodyState2D):
	if gravity_scale == 0.0:
		return
	if get_child_count() == 0:
		queue_free()
		return

	var center_of_mass_local := Vector2(0,0)
	for child in get_children() as Array[Node2D]:
		center_of_mass_local += child.position
	center_of_mass_local /= get_child_count()
	var center_of_mass := to_global(center_of_mass_local)

	if get_child_count() > 0:
		for child in get_children() as Array[CollisionShape2D]:
			var dont_move := false
			var p := child.position
			var candidate_position :Vector2= p + (center_of_mass_local - p).limit_length(merge_velocity)
			var r :float= child.shape.radius
			for b in get_children() as Array[CollisionShape2D]:
				if child == b:
					continue
				var radii :float= r + child.shape.radius
				var radii_sqrd := radii * radii
				var dist_sqrd := (b.position - p).length_squared()
				var new_dist_sqrd := (b.position - candidate_position).length_squared()
				if dist_sqrd <= radii_sqrd and new_dist_sqrd < dist_sqrd:
					# touching, and moving would make these closer
					dont_move = true
					break
			if not dont_move:
				child.position = candidate_position

	impulse_cooldown -= 1
	if impulse_cooldown < 0 and state.get_contact_count() > 0:
		var contact_point := state.get_contact_collider_position(0)
		var collider := state.get_contact_collider_object(0)
		var pos := state.get_contact_collider_position(0)
		var closest :CollisionShape2D= null
		var closest_dist :float= INF
		var closest_pos := Vector2(0,0)
		for child in get_children() as Array[Node2D]:
			var dist := (child.global_position - pos).length_squared()
			if dist < closest_dist:
				closest = child
				closest_dist = dist
				closest_pos = child.global_position
		ripple_delete(closest)
		#var offset := closest_pos - center_of_mass
		apply_impulse((closest_pos - center_of_mass).normalized() * -impulse_magnitude, closest_pos)
		#apply_torque_impulse(offset
		#angular_velocity = atan2(closest_pos.y - center_of_mass.y, closest_pos.x - center_of_mass.x)
		angular_velocity = clampf(angular_velocity, -max_angular_velocity, max_angular_velocity)
		impulse_cooldown = 10

func destroy():
	for child in get_children() as Array[Node2D]:
		child.queue_free() # TODO: Pop effect
	queue_free()

func _on_body_entered(body: Node2D):
	if (body as StaticBody2D).collision_layer & (1<<3) != 0:
		destroy()
	if (body as StaticBody2D).collision_layer & (1<<4) != 0:
		get_parent().get_parent().find_child("the kalanen").etippä_toi(self);
		print("Kalanen hengitti kuplan!")

func find_closest_spot(pos: Vector2, radius: float) -> Vector2:
	var closest_dist :float= INF
	var closest_pos := Vector2(0,0)
	for child in get_children() as Array[CollisionShape2D]:
		var diff := (child.global_position - pos)
		var dist := diff.length_squared()
		if dist < closest_dist:
			closest_dist = dist
			closest_pos = child.global_position - diff.normalized() * ((child.shape as CircleShape2D).radius + radius)
	return closest_pos

func ripple_delete(child: Node2D):
	pop(child.global_position)
	child.queue_free()

func ripple_pull(child: Node2D, position: Vector2):
	pop(child.global_position)
	child.queue_free()

func remove_closest_child(pos: Vector2):
	var closest_dist :float= INF
	var closest_child :CollisionShape2D= null
	for child in get_children() as Array[CollisionShape2D]:
		if child.get_index() == 0:
			continue
		var diff := (child.global_position - pos)
		var dist := diff.length_squared()
		if dist < closest_dist:
			closest_dist = dist
			closest_child = child
	ripple_delete(closest_child)
