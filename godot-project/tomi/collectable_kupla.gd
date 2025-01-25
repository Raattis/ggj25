extends RigidBody2D
class_name KerättäväKupla

@onready var colli = $kupla_coll

func _process(_delta: float):
	if global_position.length() > 10000:
		queue_free()
	var view_size = get_viewport_rect().size
	for child in get_children():
		if child is Pääkamera:
			continue
		var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
		renderer.push_bubble(
			(child.global_position - view_size / 2.0) / view_size.y,
			child.shape.get_radius() / view_size.y
		)


func _on_body_entered(body: Cluster):
	for c in get_children() as Array[Node2D]:
		var pos = c.global_position
		remove_child(c)
		body.add_child(c)
		var new_pos = body.find_closest_spot(pos, colli.shape.get_radius())
		c.global_position = new_pos
		
	queue_free()
