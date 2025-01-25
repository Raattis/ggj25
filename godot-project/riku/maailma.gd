extends Node2D

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene_to_file("res://paavalikko.tscn")
