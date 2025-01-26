extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

const KLONG = preload("res://riku/sfx/klong.ogg")
var bounce := 1.0
var orig_scale := Vector2(0,0)

func _ready():
	orig_scale = scale
	audio_stream_player_2d.stream = KLONG

func _process(delta: float) -> void:
	scale = orig_scale * lerp(scale.y / orig_scale.y, bounce, 0.1)
	bounce = clamp(bounce - delta * 1.0, 1.0, 100.0)

func _on_body_entered(body: Node2D) -> void:
	var cluster := (body as Cluster)
	if cluster.add_ankkuri(self):
		bounce = 2.0
		audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
		audio_stream_player_2d.volume_db = randf_range(-10, 1.0)
		audio_stream_player_2d.play()
