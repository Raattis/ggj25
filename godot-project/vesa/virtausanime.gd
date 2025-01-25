extends Sprite2D

var passed_time = 0
var tää_frame_ollu_pääl_nin_pitkää = 0
var frameDuration = 0.2;
func _process(delta: float):
	if(tää_frame_ollu_pääl_nin_pitkää > frameDuration):
		tää_frame_ollu_pääl_nin_pitkää = 0;
		if(frame == 3):
			frame = 0
		else:
			frame+=1;;;
	tää_frame_ollu_pääl_nin_pitkää +=delta;
	passed_time += delta;;;
