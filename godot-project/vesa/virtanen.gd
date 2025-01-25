extends Area2D

@export var voima:= 1
var kuplat:Array[Cluster]

var passed_time = 0

func _physics_process(_delta: float) -> void:
	var suunta = Vector2(1,0).rotated(global_rotation);
	for kupla in kuplat:
		kupla.apply_force(suunta * voima);

func _on_body_entered(body: Node2D) -> void:
	kuplat.append(body as Cluster);
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	kuplat.erase(body)
	pass # Replace with function body.
