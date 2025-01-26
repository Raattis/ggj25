extends Label

func _process(delta):
	if GameManager.anchors_collected >= 10:
		text = str(GameManager.anchors_collected) + "/10 anchors collected\nVICTORY!!\nPress a number from 1 to " + str(GameManager.map_count) + "\nto select a new map!"
	else:
		text = str(GameManager.anchors_collected) + "/10 anchors collected"
