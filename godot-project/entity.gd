class_name Porho
extends Sprite2D
var time = 0
var escape_direction := Vector2();
var escape_velocity := 0;

func _ready():
	position.x = 200;
	position.y = 200;

func _process(delta):
	time += delta
	var relevantMousePosition :Vector2= get_parent().get_local_mouse_position();
	var direction1 := relevantMousePosition - position;
	var distanceToMouse = relevantMousePosition.distance_to(position)
	var direction := (relevantMousePosition - position).normalized();
	var magnitude := sqrt((direction.x* direction.x) + (direction.y*direction.y));
	var unit_vector := direction / magnitude;
	
	
	if escape_velocity > 0:
		escape_velocity -= delta;
		position += escape_direction * escape_velocity;
	elif distanceToMouse > 10:
		position += unit_vector * delta * 650;
	
