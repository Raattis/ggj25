extends Node2D

@onready var shape_cast_2d = $ShapeCast2D
@onready var kupla = $"../kupla"
@onready var uusi_kupla = $Sprite2D

var target_position := Vector2(0,0)
var radius := 1.0

func _ready():
	radius = (kupla.find_children("*", "CollisionShape2D")[0] as CollisionShape2D).shape.radius
	shape_cast_2d.scale = Vector2(1,1) * radius / 10.0
	target_position = kupla.global_position

func _process(delta):
	position = get_parent().get_local_mouse_position()
	shape_cast_2d.target_position = target_position - position
	for coll in shape_cast_2d.collision_result:
		uusi_kupla.global_position = coll.point + coll.normal * radius
		break
