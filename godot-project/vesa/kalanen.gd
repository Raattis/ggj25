extends Area2D

var suunnanmuutokseen_vaadittu_aika = 2;
var aika_toimettomana = 0;
var aika_paikallaan = 0;
var elämänsuunta := Vector2(1,0);
var toimeton_nopeus = 60;
var olen_toimeton = true;
var kalan_koko = Vector2(1,1)
var toimeton_y_nopeus = 10;
var maailman_alaraja_x = 100;
var maailman_yläraja_x = 600;
var maailman_alaraja_y = 30;
var maailman_yläraja_y = 70;
var kuplan_metästys_kesken = false;
var kupla_kohde_sijainti := Vector2(0,0);

func etippä_toi(kuplunen : Cluster):
	kupla_kohde_sijainti = kuplunen.position
	kuplan_metästys_kesken = true;
	kuplunen.position
	olen_toimeton =false;

func _ready():
	kalan_koko = scale;

func kuplan_metsästys_tilanpäivitys(delta : float):
	var direction := Vector2(kupla_kohde_sijainti - position).normalized();
	var magnitude := sqrt((direction.x* direction.x) + (direction.y*direction.y));
	var unit_vector := direction / magnitude;
	var kupla_etäisyys = kupla_kohde_sijainti.distance_to(position)
	if kupla_etäisyys > 10:
		position += unit_vector * delta * 650;
	else:
		kuplan_metästys_kesken = false;
		olen_toimeton = true;

func toimeton_elämäntila_tilannepäivitys(delta: float):
	aika_toimettomana += delta;
	if aika_toimettomana > suunnanmuutokseen_vaadittu_aika:
		aika_toimettomana = 0
		elämänsuunta.x = randi_range(-1,1)
	position.x += toimeton_nopeus * elämänsuunta.x * delta;	

	position.x = clamp(position.x, maailman_alaraja_x, maailman_yläraja_x);
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
		position.y = clamp(position.y + elämänsuunta.y * toimeton_y_nopeus * delta, maailman_alaraja_y, maailman_yläraja_y);

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float):
	if(olen_toimeton):
		toimeton_elämäntila_tilannepäivitys(delta);;;;
		
	if kuplan_metästys_kesken:
		kuplan_metsästys_tilanpäivitys(delta);
