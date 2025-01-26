extends Area2D


func _on_body_entered(body) -> void:
	if get_parent().find_child("the kalanen") and body is Cluster:
		get_parent().find_child("the kalanen").etippä_toi(body);
