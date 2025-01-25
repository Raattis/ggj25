extends Label

func _process(delta):
	if not GameManager.bubbles_add_mode:
		queue_free()
