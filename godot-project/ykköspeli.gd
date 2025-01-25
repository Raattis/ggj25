extends Button


func _on_button_down():
	get_tree().change_scene_to_file("res://riku/maailma.tscn")

func _input(event):
	if event.as_text() == "1":
		_on_button_down()
