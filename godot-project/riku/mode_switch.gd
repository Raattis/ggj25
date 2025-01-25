extends Button

func _on_pressed():
	GameManager.bubbles_add_mode = not GameManager.bubbles_add_mode
	text = "edit\nbubbles" if GameManager.bubbles_add_mode else "edit\nmap"

func _input(event):
	if event.is_action_pressed("mode_switch"):
		_on_pressed()
