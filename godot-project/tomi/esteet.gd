extends Node

func _ready():
	
	#for c in get
	
	var c =  get_child(0).find_children("*", "CollisionShape2D")[0]
	c.shape.radius = 9.8
	
	for p in get_children():
		if p is PiikkiKala:
			p.pyöri_ku_osuu = true
