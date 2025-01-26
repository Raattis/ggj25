extends Polygon2D

func _ready():
	var new = CollisionPolygon2D.new(	)
	get_parent().add_child.call_deferred(new)
	new.polygon = polygon
	new.position = position	
