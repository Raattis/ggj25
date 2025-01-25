extends Sprite2D

func _process(delta):
	rotation = sin(Time.get_ticks_msec() / 1000.0) * 0.3
