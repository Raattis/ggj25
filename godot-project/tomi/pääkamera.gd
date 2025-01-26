extends Camera2D

class_name Pääkamera

@onready var label = $"../ruokittu_info"
@onready var flying_game = $".."

func _process(delta):
	label.text = "Kaloja on ruokittu " + str(flying_game.kalat_ruokittu) + " / " + str(flying_game.kaloja_on)
