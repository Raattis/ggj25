extends Area2D

var suunnanmuutokseen_vaadittu_aika = 2.0;
var aika_toimettomana = 0.0;
var aika_paikallaan = 0.0;
var elämänsuunta := Vector2(1,0);
var toimeton_nopeus = 60;
var olen_toimeton = true;
var kalan_koko = Vector2(1,1)
var toimeton_y_nopeus = 10;
@export var kalan_alue := Vector4(0,0,0,0);
var kuplan_metästys_kesken = false;
var kupla_saattaa_muuttua_nulliksi : Cluster
var kupla_kohde_sijainti := Vector2(0,0);
var huojunta := 0.0

func etippä_toi(kuplunen : Cluster):
	kupla_saattaa_muuttua_nulliksi = kuplunen
	kupla_kohde_sijainti = kuplunen.position
	kuplan_metästys_kesken = true
	olen_toimeton =false

func _ready():
	find_child("kalasprite").find_child("animenaama").frame = 0;
	kalan_koko = scale;

func kuplan_metsästys_tilanpäivitys(delta : float):
	huojunta += delta * 4.0
	if(kupla_saattaa_muuttua_nulliksi):
		kupla_kohde_sijainti = kupla_saattaa_muuttua_nulliksi.position;
	else:
		kuplan_metästys_kesken = false;
		olen_toimeton = true;
		find_child("kalasprite").find_child("animenaama").frame = 3;
		return
		
	var direction := Vector2(kupla_kohde_sijainti - position).normalized();
	var magnitude := sqrt((direction.x* direction.x) + (direction.y*direction.y));
	var unit_vector := direction / magnitude;
	var kupla_etäisyys = kupla_kohde_sijainti.distance_to(position)
	if(direction.x < 0):
		scale.x = kalan_koko.x;
	else:
		scale.x = -kalan_koko.x;
	if kupla_etäisyys > 10:
		position += unit_vector * delta * 400;
		find_child("kalasprite").find_child("animenaama").frame = 2
	else:
		find_child("kalasprite").find_child("animenaama").frame = 1

func toimeton_elämäntila_tilannepäivitys(delta: float):
	huojunta += delta * 2.0
	aika_toimettomana += delta;
	if aika_toimettomana > suunnanmuutokseen_vaadittu_aika:
		aika_toimettomana = 0
		elämänsuunta.x = randi_range(-1,1)
	position.x += toimeton_nopeus * elämänsuunta.x * delta;	

	position.x = clamp(position.x, kalan_alue.x, kalan_alue.z);
	if(elämänsuunta.x != 0):
		aika_paikallaan = 0;
		elämänsuunta.y = 0;
		scale.x = -kalan_koko.x * elämänsuunta.x;
	else:
		aika_paikallaan += delta;
		if(aika_paikallaan > 0.2):
			aika_paikallaan = 0;
			if(randi_range(0,1)):
				elämänsuunta.y = 1
			else:
				elämänsuunta.y = -1
		position.y = clamp(position.y + elämänsuunta.y * toimeton_y_nopeus * delta, kalan_alue.y, kalan_alue.w);

func _process(delta: float):
	if(olen_toimeton):
		toimeton_elämäntila_tilannepäivitys(delta);;;;
		
	if kuplan_metästys_kesken:
		kuplan_metsästys_tilanpäivitys(delta);
	
	huojunta += delta * 0.5
	rotation = sin(huojunta) * 0.1
