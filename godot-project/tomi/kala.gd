extends RigidBody2D
class_name Kala

const SYDÄN = preload("res://tomi/sydän.tscn")
@onready var sprite_2d = $Sprite2D

var ruokittu = false

func spawn_sydän():
	if ruokittu:
		return false
	ruokittu = true
	var mew = SYDÄN.instantiate()
	add_child(mew)
	gravity_scale = -1
	sprite_2d.self_modulate = Color(.51, .41, .31, 1)
	return true
	
