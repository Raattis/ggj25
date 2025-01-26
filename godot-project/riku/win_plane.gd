extends Area2D

func _on_body_entered(body):
	GameManager.win_area_hit.emit(body, self)

func _process(delta):
	GameManager.win_grow = clampf(GameManager.win_grow - delta, 1.0, 2.0)
	scale = Vector2(1,1) * GameManager.win_grow
	rotation = sin(Time.get_ticks_msec() / 1500.0)
