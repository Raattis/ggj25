extends Button


func _on_button_down():
	get_tree().change_scene_to_file("res://tomi/flying_game.tscn")

func _input(event):
	if event.is_pressed():
		if event.as_text() == "2" or event.as_text() == "Space" or event.as_text() == "Enter":
			_on_button_down()
