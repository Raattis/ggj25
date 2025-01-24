extends ColorRect

class Bubble:
	var pos: Vector2
	var radius: float

var bubbles_pos = []
var bubbles_radius = []

func _init() -> void:
	for i in range(0, 128):
		bubbles_pos.push_back(Vector2(i / 128.0, randf()) - Vector2(0.5, 0.5))
		bubbles_radius.push_back(randf_range(0.01, 0.1))

func _process(delta: float) -> void:
	var time = Time.get_ticks_msec() / 1000.0
	
	var aspect_ratio = size.x / size.y
	material.set_shader_parameter("aspect_ratio", aspect_ratio)

#	for i in range(0, bubbles_pos.size()):
#		bubbles_pos[i] = Vector2(sin(i + time * cos(i*1.2 + time)), cos(i + time * sin(i * 3.4 + time))) * 0.75
		
	material.set_shader_parameter("bubbles_pos", bubbles_pos)
	material.set_shader_parameter("bubbles_radius", bubbles_radius)
