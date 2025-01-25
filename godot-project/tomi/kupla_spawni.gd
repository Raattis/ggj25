extends Node2D

const COLLECTABLE_KLUPLA = preload("res://tomi/collectable_klupla.tscn")

var last_spawn_time = 0.0
var spawn_cycle = 5.0

func _init():
	spawn_cycle = 7.5 + 10 * randf()
	last_spawn_time = randf() * spawn_cycle

func _process(delta):
	last_spawn_time -= delta
	if last_spawn_time < 0:
		spawn()
		last_spawn_time = spawn_cycle * (0.8 + 0.2 * randf())
		
		
func spawn():
	if get_child_count() > 10:
		return
	var new = COLLECTABLE_KLUPLA.instantiate()
	add_child(new)
	new.set_size(5 + 10 * randf())
