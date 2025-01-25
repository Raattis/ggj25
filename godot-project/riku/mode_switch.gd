extends Button

func _on_button_down():
	kursori.bubbles_add_mode = not kursori.bubbles_add_mode
	text = "edit\nbubbles" if kursori.bubbles_add_mode else "edit\nmap"

func _input(event):
	if event.is_action_pressed("mode_switch"):
		_on_button_down()
