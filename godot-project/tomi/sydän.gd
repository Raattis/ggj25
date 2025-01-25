extends Node2D

var offset = Vector2(-10, 0)
var up_speed = -10
var size_speed = 1
var life_time = 5
var size_acc = 0.1

func _process(delta):
	offset.y += delta * up_speed
	size_acc += delta * size_speed
	scale = Vector2.ONE * size_acc
	position = offset
	life_time -= delta
	if life_time < 0:
		queue_free()
