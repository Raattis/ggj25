extends CollisionShape2D

func _process(delta: float) -> void:
	var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
	var view_size = get_viewport_rect().size
	renderer.push_bubble(
		(global_position - view_size / 2.0) / view_size.y,
		shape.get_radius() / view_size.y
	)
