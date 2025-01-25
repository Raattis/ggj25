extends Area2D


func _physics_process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var cluster := (body as Cluster)
	cluster.gravity_scale = 1;
	cluster.anchors_collected += 1
