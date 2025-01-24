extends RichTextLabel

func _draw() -> void:
	text = "TIME: " + str(Time.get_ticks_msec())
	print("mitäs vittua")
	
	rotation = Time.get_ticks_msec()
	
	queue_redraw()
