extends Area2D

@export var suunta:= Vector2(0,0);;;;

var kuplat:Array[Cluster]

var passed_time = 0

func virtaus(delta):
	pass	


func _physics_process(delta: float) -> void:
	for kupla in kuplat:
		kupla.apply_force(suunta);

func _process(delta: float):
	pass

func _on_body_entered(body: Node2D) -> void:
	kuplat.append(body as Cluster);
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	kuplat.erase(body)
	pass # Replace with function body.
