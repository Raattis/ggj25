extends Area2D

@export var voima:= 1
var kuplat:Array[Cluster]

var passed_time = 0

func _physics_process(delta: float) -> void:
	var suunta = Vector2(1,0).rotated(rotation);
	for kupla in kuplat:
		kupla.apply_force(suunta * voima);

func _process(delta: float):
	print(	rotation);
	pass

func _on_body_entered(body: Node2D) -> void:
	kuplat.append(body as Cluster);
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	kuplat.erase(body)
	pass # Replace with function body.
