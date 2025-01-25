extends Sprite2D
class_name Poks


var passed_time = 0
var duration = 0.05;
var frame_duration = duration / 4.0;


func _ready():
	pass

func _process(delta: float):
	var frame_index = passed_time / frame_duration;
	if frame_index >= 4:
		queue_free();;;;;
		return
	passed_time += delta;
	frame = frame_index
