extends Node2D

const KUPLA_SPAWNI = preload("res://tomi/kupla_spawni.tscn")
const KALA = preload("res://tomi/kala.tscn")
@onready var kalat_parentti = $"../kalat_parentti"


func _ready():
	
	for x in range(10.0, 600, 50):
		for y in range(10.0, 400, 50):
			if y > 1000:
				continue
			continue # skip levä
			var new = KUPLA_SPAWNI.instantiate()
			add_child(new)
			new.position = Vector2(x + randf() * 10, y + randf() * 10)
	for n in range(99):
		var new = KALA.instantiate()
		kalat_parentti.add_child(new)
		new.position = Vector2(100.0 + 1800 * randf(),100.0 + 1800 * randf())
