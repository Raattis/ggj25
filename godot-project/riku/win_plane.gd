extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
const COLLECT = preload("res://riku/sfx/collect.ogg")
func _on_body_entered(body):
	GameManager.win_area_hit.emit(body, self)

func _process(delta):
	GameManager.win_grow = clampf(GameManager.win_grow - delta, 1.0, 2.0)
	scale = Vector2(1,1) * GameManager.win_grow
	rotation = sin(Time.get_ticks_msec() / 1500.0)

func collect():
	audio_stream_player_2d.stream = COLLECT
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.volume_db = randf_range(-15.0, -10.0)
	audio_stream_player_2d.play()
