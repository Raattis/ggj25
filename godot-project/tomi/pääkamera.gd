extends Camera2D

class_name Pääkamera

func _process(delta):
	var p = get_parent()
	if p is RigidBody2D:
		var speed = p.linear_velocity.length()
		if speed <= 10:
			zoom = Vector2.ONE * lerp(zoom.x, 2.0, 2 * delta)
		else:
			var z = -((speed-10) / 200) + 2
			zoom =  Vector2.ONE * lerp(zoom.x, z, 2 * delta)
			
