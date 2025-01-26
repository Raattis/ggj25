extends Node2D
class_name FlyingGame

var kalat_ruokittu = 0
var kaloja_on = 0

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene_to_file("res://paavalikko.tscn")
