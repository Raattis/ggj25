extends Node2D
class_name FlyingGame

var kalat_ruokittu = 0
var kaloja_on = 0

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene_to_file("res://paavalikko.tscn")
		
@onready var label = $"ruokittu_info"

func _process(delta):
	if kalat_ruokittu < kaloja_on:
		label.text = "Kaloja on ruokittu " + str(kalat_ruokittu) + " / " + str(kaloja_on)
	else: 
		label.text = "Mahtavaa, toivottavasti saat nukuttua yösi hyvin!"
