extends Sprite2D

var t = 0.0

func _input(event):
	if event.is_pressed() and event.as_text() == "T":
		visible = not visible
		
func _process(delta):
	t += delta
	position = Vector2(
		1000 + 50 * sin(t * .05),
		1000 + 50 * sin((t + 1) * .051),
	)
