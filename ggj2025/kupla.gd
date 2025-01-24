extends RigidBody2D
class_name Kupla

var size = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_body_entered(body: Node):
	if size == 0:
		queue_free()
		scale = Vector2.ZERO
		return
	if body is Kupla:
		if size >= body.size:
			size = size + body.size
			body.size = 0
			
	update_size()
	
func update_size():
	var new_shape = CircleShape2D.new()
	var r = sqrt(size)
	new_shape.radius = r * 8
	$CollisionShape2D.shape = new_shape
	$Sprite2D.scale = Vector2(0.029 * r, 0.029 * r)
	constant_force.y = -10 * size
