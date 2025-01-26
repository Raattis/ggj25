extends Sprite2D


@onready var coll = $"../coll"

var o := 0.0

func _ready():
	o = randf() * 12.0


func _process(delta):
	position.y = sin(Time.get_ticks_msec() / 300.0 + o)
	position.x = sin(Time.get_ticks_msec() / 250.0 + 50 + o)
	scale = Vector2(1,1) * coll.shape.radius / 5.0 * 0.03
