extends Label

var camera_orig := Vector2(0,0)

func _process(_delta):
	if camera_orig.length() == 0.0:
		camera_orig = get_viewport().get_camera_2d().position
	elif (camera_orig - get_viewport().get_camera_2d().position).length() > 100.0:
		queue_free()
