extends CollisionShape2D

func _process(delta: float) -> void:
	var asdf: SceneVis = scenevis.find_child("ColorRect")
	# TODO nää kuntoon
	asdf.push_bubble((global_position - Vector2(500, 200)) / 1000, 0.05)
