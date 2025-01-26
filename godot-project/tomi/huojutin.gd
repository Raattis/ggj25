extends Sprite2D

var erotin := 3.0 * randf()
var t := 0.0

var speed = 1



func _process(delta):
	t += delta
	rotation_degrees = sin(t*speed + erotin) * 5
