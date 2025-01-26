extends Sprite2D


func _input(event):
	if event.is_pressed() and event.as_text() == "T":
		visible = not visible
