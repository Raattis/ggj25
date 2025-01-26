extends RigidBody2D
class_name KerättäväKupla

@onready var colli = $kupla_coll
@onready var sprite_2d = $kupla_coll/Sprite2D

var min_size = 1
var shrink_speed = 2
var size = 10

func _process(_delta: float):
	var view_size = get_viewport_rect().size
	for child in get_children():
		if child is Pääkamera:
			continue
		var renderer: SceneVis = scenevis.find_child("BubbleSceneRenderer")
		renderer.push_bubble(
			(child.global_position - view_size / 2.0) / view_size.y,
			child.shape.get_radius() / view_size.y
		)
	var shrink = shrink_speed * _delta
	size -= shrink
	update_gfx()
	if size < min_size:
		queue_free()


func _on_body_entered(body):
	if not body is Cluster:
		return
	for c in get_children() as Array[Node2D]:
		var pos = c.global_position
		remove_child(c)
		body.add_child(c)
		var new_pos = body.find_closest_spot(pos, colli.shape.get_radius())
		c.global_position = new_pos
		
	queue_free()

func set_size(new_size:float):
	size = new_size
	update_gfx()

func update_gfx():
	colli.shape = CircleShape2D.new()
	colli.shape.radius = size
	sprite_2d.scale = Vector2.ONE * 0.0034 * size
	
