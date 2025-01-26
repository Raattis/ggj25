extends Node2D

const KUPLA_SPAWNI = preload("res://tomi/kupla_spawni.tscn")
const KALA = preload("res://tomi/kala.tscn")


func _init():
	for x in range(0.0, 2000, 150):
		for y in range(0.0, 2000, 150):
			var new = KUPLA_SPAWNI.instantiate()
			add_child(new)
			new.position = Vector2(x + randf() * 100, y + randf() * 100)
	for n in range(99):
		var new = KALA.instantiate()
		add_child(new)
		new.position = Vector2(100.0 + 1800 * randf(),100.0 + 1800 * randf())
