extends Sprite2D
var passed_time = 0
var duration = 0.05;
var frame_duration = duration / 4;
func _ready():
	pass

func _process(delta: float):
	passed_time += delta;
	frame = passed_time / frame_duration;
	if passed_time > duration:
		queue_free();;;;;
	pass
