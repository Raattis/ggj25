extends Area2D

var dragging := false
var offset := Vector2(0,0)
var start := Vector2(0,0)

@export var TYYPIT :Array[PackedScene]
var tyyppi :int= -1
var obu :Node2D= null

func _ready():
	next()

func next():
	tyyppi = (tyyppi + 1) % TYYPIT.size()
	if obu:
		obu.queue_free()
	obu = TYYPIT[tyyppi].instantiate()
	add_child(obu)
	obu.position = Vector2(0,0)

func _process(delta):
	if dragging and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		global_position = get_global_mouse_position() + offset
	else:
		if dragging and (start - get_global_mouse_position()).length() < 3:
			next()
		dragging = false

func is_mouse_over() -> bool:
	return ((get_global_mouse_position() - global_position) * scale).length() < ($CollisionShape2D.shape as CircleShape2D).radius

func _input(event : InputEvent):
	if event is InputEventMouse and dragging:
		if event.is_pressed() and (event.button_index == MOUSE_BUTTON_WHEEL_UP or event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			var rot := 1.0 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1.0
			obu.rotate(rot * PI / 16)
		if event.is_pressed() and (event.button_index == MOUSE_BUTTON_LEFT):
			queue_free()

	if event is InputEventMouse:
		if event is InputEventMouseButton and event.pressed and is_mouse_over():
			if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
				dragging = true
				start = get_global_mouse_position()
				offset = global_position - get_global_mouse_position()
