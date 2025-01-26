extends RigidBody2D
class_name Kala

const SYDÄN = preload("res://tomi/sydän.tscn")
@onready var sprite_2d = $Sprite2D
var flying_game = null

@export var hungry := 1
@export var shrink_when_ready = false

@onready var label = $Label


func _ready():
	flying_game = get_tree().get_current_scene() as FlyingGame
	flying_game.kaloja_on += 1


func spawn_sydän():
	if hungry <= 0:
		return false
	if hungry == 1:
		flying_game.kalat_ruokittu += 1
		gravity_scale = -.2
		sprite_2d.self_modulate = Color(.51, .41, .31, 1)
		if shrink_when_ready:
			set_collision_layer_value(6, false)
			set_collision_layer_value(7, true)
			set_collision_mask_value(2, false) # ei pelaajaan törmättöis  
	hungry -= 1
	if label:
		label.text = str(hungry)
		if hungry <= 0:
			label.text = ""
	var mew = SYDÄN.instantiate()
	add_child(mew)
	return true
	
