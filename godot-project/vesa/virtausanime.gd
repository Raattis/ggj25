extends Sprite2D

var passed_time = 0
var tää_frame_ollu_pääl_nin_pitkää = 0
var frameDuration = 0.2
var o := 0.0

func _ready():
	o = randf() * 12.0

func _process(delta: float):
	if(tää_frame_ollu_pääl_nin_pitkää > frameDuration):
		tää_frame_ollu_pääl_nin_pitkää = 0
		if(frame == 3):
			frame = 0
		else:
			frame += 1
	tää_frame_ollu_pääl_nin_pitkää += delta
	passed_time += delta

	position.y = sin(Time.get_ticks_msec() / 300.0 + o) * 5
	position.x = sin(Time.get_ticks_msec() / 400.0 + 50 + o) * 5
