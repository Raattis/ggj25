extends Node2D

@onready var target :Cluster= $"../cluster"
@onready var uusi_kupla :Node2D= $"../uusi_kupla"
@onready var kamera = $"../Pääkamera"

const KUPLA_GFX := preload("res://riku/kupla_gfx.tscn")
const KUPLA_COLL := preload("res://riku/kupla_coll.tscn")
var cluster_parent : Node2D = null

@export var gravity_scale := -1.0 # miten aktiivisen kuplan pitäisi kelluuntua
@export var linear_damping := 2.0
@export var angular_damping := 0.1
@export var impulse_magnitude := 300.0
@export var max_angular_velocity := 10000.0
@export var auto_launch_cooldown := 1.0

@export var tee_auto_laukaisuja := true
@export var näytä_kuplia := false
var target_position :Vector2= Vector2(0,0)
var was_pressd :bool= false
var launch_cooldown :float= 0.5
var spawn_cooldown :float= 0.5
var spawn_radius := 0.1
var spawn_radius_grow_sign := 1.0

func _ready():
	var rect := get_viewport().get_visible_rect()
	target.global_position.y = rect.position.y + rect.size.y * 0.9
	target.global_position.x = rect.position.x + rect.size.x * 0.5
	target_position = target.global_position


func _process(delta: float):
	if not cluster_parent:
		cluster_parent = Node2D.new()
		cluster_parent.name = "cluster_parent"
		get_parent().add_child(cluster_parent)
		get_parent().move_child(cluster_parent, 0)

	spawn_cooldown -= delta
	if Input.is_action_pressed("spawn") and GameManager.bubbles_add_mode:
		spawn_radius += delta * 20.0 * spawn_radius_grow_sign
		if spawn_radius > 30.0:
			spawn_radius_grow_sign = -1.0
		elif spawn_radius < 4:
			spawn_radius_grow_sign = 1.0

	position = get_parent().get_local_mouse_position()
	var target_pos := target.find_closest_spot(position, spawn_radius)
	var t :float= 1.0 - pow(0.00001, delta)
	uusi_kupla.global_position = lerp(uusi_kupla.global_position, target_pos, t)
	uusi_kupla.visible = GameManager.bubbles_add_mode
	if GameManager.bubbles_add_mode:
		var view_size = get_viewport_rect().size
		var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
		renderer.push_bubble(
			(uusi_kupla.global_position - view_size / 2.0) / view_size.y,
			spawn_radius / view_size.y
		)
	launch_cooldown -= delta
	if launch_cooldown < 0 and tee_auto_laukaisuja:
		launch()

	if Input.is_action_just_pressed("laukaise") and launch_cooldown < 0 and GameManager.bubbles_add_mode:
		launch()

func launch():
	if cluster_parent.get_child_count() > 15: # MAX CLUSTER COUNT
		return
	launch_cooldown = auto_launch_cooldown
	var new :RigidBody2D= target.duplicate()
	cluster_parent.add_child(new)
	new.collision_layer = 2
	new.collision_mask = ((1<<8)-1) & ~3
	new.gravity_scale = gravity_scale
	new.linear_damp = linear_damping
	new.angular_damp = angular_damping
	new.impulse_magnitude = impulse_magnitude
	new.max_angular_velocity = max_angular_velocity
	new.kulkee = true
	if kamera:
		if kamera.get_parent():
			kamera.get_parent().remove_child(kamera)
		new.add_child(kamera)
		kamera.position = Vector2.ZERO

const SIIRRELTAVA = preload("res://riku/siirreltava.tscn")
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.double_click and event.button_index == MOUSE_BUTTON_LEFT and not GameManager.bubbles_add_mode:
		var siirreltava := SIIRRELTAVA.instantiate()
		$"..".find_child("siirreltavat", true).add_child(siirreltava)
		siirreltava.global_position = get_global_mouse_position()
	if event.is_action_pressed("launch"):
		launch()
	if event.is_action_pressed("remove") and target.get_child_count() > 1 and GameManager.bubbles_add_mode:
		target.remove_closest_child(position)
	if event.is_action_released("spawn") and spawn_cooldown < 0.0 and GameManager.bubbles_add_mode:
		if target.get_child_count() > 31:
			target.remove_child(target.get_child(31))
			spawn_cooldown = 0.5
		else:
			var cll = KUPLA_COLL.instantiate()
			var gfx = KUPLA_GFX.instantiate()
			cll.add_child(gfx)
			gfx.visible = näytä_kuplia
			target.add_child(cll)
			cll.global_position = uusi_kupla.global_position
			cll.shape = CircleShape2D.new()
			cll.shape.radius = spawn_radius
			gfx.scale = Vector2.ONE * 0.0034 * spawn_radius
			spawn_radius = target.get_child(0).shape.get_radius()
			#launch()
	#if event is InputEventMouseMotion and Input.is_action_pressed("move_camera"):
	#	get_viewport().get_camera_2d().position.y -= event.relative.y
