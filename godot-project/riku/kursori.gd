extends Node2D

@onready var target :Cluster= $"../cluster"
@onready var uusi_kupla :Node2D= $"../uusi_kupla"
const KUPLA_GFX := preload("res://riku/kupla_gfx.tscn")
const KUPLA_COLL := preload("res://riku/kupla_coll.tscn")

var gravity_scale := -1.0
var linear_damping := 1.0
var angular_damping := 0.9

var target_position := Vector2(0,0)
var was_pressd := false
var launch_cooldown := 0.5

func _ready():
	var rect := get_viewport().get_visible_rect()
	target.global_position.y = rect.position.y + rect.size.y * 0.9
	target.global_position.x = rect.position.x + rect.size.x * 0.5
	target_position = target.global_position

func _process(delta: float):
	position = get_parent().get_local_mouse_position()
	var target_pos := target.find_closest_spot(position)
	var t :float= 1.0 - pow(0.00001, delta)
	uusi_kupla.global_position = lerp(uusi_kupla.global_position, target_pos, t)
	if Input.is_action_pressed("spawn"):
		if not was_pressd:
			was_pressd = true
			var cll = KUPLA_COLL.instantiate()
			var gfx = KUPLA_GFX.instantiate()
			cll.add_child(gfx)
			target.add_child(cll)
			cll.global_position = uusi_kupla.global_position
			#gfx.global_position = uusi_kupla.global_position
			launch()
	else:
		was_pressd = false
	launch_cooldown -= delta
	if launch_cooldown < 0:
		launch()
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Engine.physics_ticks_per_second = 120
		Engine.time_scale = 2
	else:
		Engine.physics_ticks_per_second = 60
		Engine.time_scale = 1

func launch():
	launch_cooldown = 1.0
	var new :RigidBody2D= target.duplicate()
	get_parent().add_child(new)
	get_parent().move_child(new, target.get_index())
	new.collision_layer = 2
	new.collision_mask = ((1<<8)-1) & ~3
	new.gravity_scale = gravity_scale
	new.linear_damp = linear_damping
	new.angular_damp = angular_damping

func _input(event: InputEvent):
	if event.is_action_pressed("launch"):
		launch()
