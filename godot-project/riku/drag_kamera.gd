extends Camera2D


func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_action_pressed("move_camera"):
		position.y -= event.relative.y
