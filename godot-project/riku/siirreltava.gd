extends Area2D

@export var TYYPIT : Array[PackedScene]

var tyyppi := 0
var instance :Node2D= null

func next():
	if instance:
		instance.queue_free()
	tyyppi = (tyyppi + 1) % TYYPIT.size()
	instance = TYYPIT[tyyppi].instantiate()
	add_child(instance)
	instance.position = Vector2(0,0)

func _ready():
	tyyppi = randi()
	next()

func _process(delta):
	mouse_entered

func _on_siirreltava_input_event(viewport, node, idx):
	print("aAAAAAAAAAAAAAAAAAAAAAA")
