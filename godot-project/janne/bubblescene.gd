class_name SceneVis
extends ColorRect

class Bubble:
	var pos: Vector2
	var radius: float

var bubbles_pos = []
var bubbles_radius = []

func push_bubble(pos: Vector2, radius: float):
	bubbles_pos.push_back(pos)
	bubbles_radius.push_back(radius)

func _process(delta: float) -> void:
	var time = Time.get_ticks_msec() / 1000.0
	var mat: ShaderMaterial = material;
	
	var aspect_ratio = size.x / size.y
	mat.set_shader_parameter("aspect_ratio", aspect_ratio)
	
	mat.set_shader_parameter("bubbles_active_count", float(bubbles_pos.size()))
	mat.set_shader_parameter("bubbles_pos", bubbles_pos)
	mat.set_shader_parameter("bubbles_radius", bubbles_radius)
	
	bubbles_pos.clear()
	bubbles_radius.clear()
