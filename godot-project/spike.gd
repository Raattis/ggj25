extends Sprite2D
@onready var entity: Porho = $"../Entity"
var disabledForSeconds = 0;
func _ready():
	position.x = randf_range(0,get_viewport_rect().size.x);
	position.y = randf_range(0,get_viewport_rect().size.y);;

func _process(delta):

	if disabledForSeconds == 0:
		if entity.position.distance_to(position) < 80:
			entity.escape_velocity = 30;
			var direction := (entity.position - position).normalized();
			entity.escape_direction = direction;
			disabledForSeconds = 0.5;
		pass
	pass

	if(disabledForSeconds > 0):
		disabledForSeconds -= delta;
	else:
		disabledForSeconds = 0;
