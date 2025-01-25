extends Sprite2D

var o := 0.0

func _ready():
	o = randf() * 12.0


func _process(delta):
	position.y = sin(Time.get_ticks_msec() / 300.0 + o)
	position.x = sin(Time.get_ticks_msec() / 250.0 + 50 + o)
