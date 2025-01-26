extends Label

@onready var audio_stream_player = $AudioStreamPlayer

const TADAA_2 = preload("res://riku/sfx/tadaa2.ogg")
const TADAA = preload("res://riku/sfx/tadaa.ogg")
const WIN := 20
var won := false

func _process(delta):
	if GameManager.anchors_collected >= WIN:
		if not won:
			won = true
			audio_stream_player.stream = TADAA if randi() % 2 == 1 else TADAA_2
			audio_stream_player.play()
		text = str(GameManager.anchors_collected) + "/" + str(WIN) + " anchors collected\nVICTORY!!\nPress a number from 1 to " + str(GameManager.map_count) + "\nto select a new map!"
	else:
		text = str(GameManager.anchors_collected) + "/" + str(WIN) + " anchors collected"
