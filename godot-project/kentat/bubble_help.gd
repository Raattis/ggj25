extends Label

func _process(delta):
	visible = GameManager.bubbles_add_mode
	if GameManager.anchors_collected > 5:
		queue_free()
