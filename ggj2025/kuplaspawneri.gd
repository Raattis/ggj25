extends Node2D

var kupla = preload("res://kupla.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var obj = kupla.instantiate()
		obj.position = get_global_mouse_position()
		add_child(obj)
