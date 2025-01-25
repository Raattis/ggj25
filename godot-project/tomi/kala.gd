extends RigidBody2D
class_name Kala

const SYDÄN = preload("res://tomi/sydän.tscn")

var ruokittu = false

func spawn_sydän():
	if ruokittu:
		return false
	ruokittu = true
	var mew = SYDÄN.instantiate()
	add_child(mew)
	return true
	
