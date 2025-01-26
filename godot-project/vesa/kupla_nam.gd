extends Area2D


func _on_body_entered(body: Node2D) -> void:
	get_parent().find_child("the kalanen").etippä_toi(body);
	pass # Replace with function body.
