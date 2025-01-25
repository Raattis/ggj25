extends Button

func _on_pressed():
	var kursori :Kursori= get_tree().root.get_node("maailma/kursori")
	kursori.bubbles_add_mode = not kursori.bubbles_add_mode
	text = "edit\nbubbles" if kursori.bubbles_add_mode else "edit\nmap"

func _input(event):
	if event.is_action_pressed("mode_switch"):
		_on_pressed()
