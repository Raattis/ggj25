extends Sprite2D
var passed_time := 0.0
var duration = 0.05
var frame_duration = duration / 4.0
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

const POP_1 = preload("res://riku/sfx/pop1.ogg")
const POP_2 = preload("res://riku/sfx/pop2.ogg")

func _ready():
	audio_stream_player_2d.stream = POP_1 if randi() % 2 == 0 else POP_2
	audio_stream_player_2d.pitch_scale = randf_range(0.7, 1.2)
	audio_stream_player_2d.volume_db = randf_range(-10.0 * audio_stream_player_2d.pitch_scale, 1.0 / audio_stream_player_2d.pitch_scale)
	audio_stream_player_2d.play()

func _process(delta: float):
	var frame_index :int= passed_time / frame_duration
	passed_time += delta
	if frame_index < 4:
		frame = frame_index
	if frame_index >= 4 and audio_stream_player_2d.finished:
		queue_free()
