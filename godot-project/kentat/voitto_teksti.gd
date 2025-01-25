extends Label

func _process(delta):
	if GameManager.anchors_collected >= 10:
		text = str(GameManager.anchors_collected) + "/10 anchors collected\nVICTORYY!!\nPress number from 1 to " + str(GameManager.map_count)
	else:
		text = str(GameManager.anchors_collected) + "/10 anchors collected"
