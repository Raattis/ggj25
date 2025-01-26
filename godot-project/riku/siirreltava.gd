extends Area2D

var dragging := false
var offset := Vector2(0,0)
var start := Vector2(0,0)
var done_stuff := false

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

func _process(_delta):
	if GameManager.bubbles_add_mode:
		dragging = false
		modulate.a = 0.2
		return

	modulate.a = 0.8
	if dragging and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_global_mouse_position() + offset
	else:
		if dragging and (start - get_global_mouse_position()).length() < 3 and not done_stuff:
			next()
		dragging = false

func is_mouse_over() -> bool:
	return ((get_global_mouse_position() - global_position) * scale).length() < ($CollisionShape2D.shape as CircleShape2D).radius

func _input(event : InputEvent):
	if GameManager.bubbles_add_mode:
		return
	var mb := event as InputEventMouseButton
	if mb and (mb.button_index == MOUSE_BUTTON_WHEEL_UP or mb.button_index == MOUSE_BUTTON_WHEEL_DOWN):
		if (is_mouse_over() and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) or dragging:
			var rot := 1.0 if mb.button_index == MOUSE_BUTTON_WHEEL_UP else -1.0
			obu.rotate(rot * PI / 16)
			done_stuff = true
	if mb and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT and is_mouse_over():
		queue_free()
		done_stuff = true
	if mb and event.pressed and is_mouse_over() and mb.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			done_stuff = false
			start = get_global_mouse_position()
			offset = global_position - get_global_mouse_position()
