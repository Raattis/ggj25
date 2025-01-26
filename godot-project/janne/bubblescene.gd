class_name SceneVis
extends ColorRect

var bubbles_pos = []
var bubbles_radius = []
var bubbles_extra = []

var orig_camera_initialized = false
var orig_camera_pos: Vector2

func push_bubble(pos: Vector2, radius: float, extra: float = 0.0):
	bubbles_pos.push_back(pos)
	bubbles_radius.push_back(radius)
	bubbles_extra.push_back(extra)

func _process(_delta: float) -> void:
	var mat: ShaderMaterial = material;

	if !orig_camera_initialized && get_viewport().get_camera_2d():
		orig_camera_pos = get_viewport().get_camera_2d().position
		orig_camera_initialized = true

	if orig_camera_initialized:
		var camera = get_viewport().get_camera_2d()
		if not camera:
			return
		get_parent().position = camera.position - get_parent().size / 2.

		var camera_offset := get_viewport().get_camera_2d().position - orig_camera_pos
		# HEI JANNE! Tassa sulle kameran offsetti :)
		var normalized = camera_offset / size
		mat.set_shader_parameter("camera_offset",normalized )

		# Päivittele taustan cameraaaaaaaaa
		var bgscene_camera: Camera3D = get_parent().find_child("Camera3D")
		bgscene_camera.position.y = 1.5 - normalized.y * 8.;

	var aspect_ratio = size.x / size.y
	mat.set_shader_parameter("aspect_ratio", aspect_ratio)
	
	mat.set_shader_parameter("bubbles_active_count", float(bubbles_pos.size()))
	mat.set_shader_parameter("bubbles_pos", bubbles_pos)
	mat.set_shader_parameter("bubbles_radius", bubbles_radius)
	mat.set_shader_parameter("bubbles_extra", bubbles_extra)

	bubbles_pos.clear()
	bubbles_radius.clear()
	bubbles_extra.clear()
