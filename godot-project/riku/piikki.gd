extends StaticBody2D
class_name PiikkiKala

@export var voi_disabloida := false
@export var pyöri_ku_osuu := true


var disablointi_aika = 5.0
var pyöri_nopeus = 0.0
var hidastuminen = 200.0

func _process(delta):
	if pyöri_ku_osuu and pyöri_nopeus > 0:
		rotation_degrees += pyöri_nopeus * delta
		pyöri_nopeus -= delta * hidastuminen

func pelaaja_hittas():
	if pyöri_ku_osuu:
		pyöri_nopeus = 500.0
