class_name Mapit
extends Node

@export var arr : Array[PackedScene] = []

func _ready():
	GameManager.map_count = arr.size()
	load_map(0)

func load_map(i: int):
	if i >= arr.size():
		return
	var n := arr[i].instantiate()
	if get_child_count() > 0:
		remove_child(get_child(0))
	add_child(n)
	GameManager.siirreltavat = n.find_child("siirreltavat")
	GameManager.map_changed = true
	GameManager.anchors_collected = 0

func _input(event: InputEvent):
	var k := event as InputEventKey
	if k and k.keycode == KEY_1:
		load_map(0)
	if k and k.keycode == KEY_2:
		load_map(1)
	if k and k.keycode == KEY_3:
		load_map(2)
	if k and k.keycode == KEY_4:
		load_map(3)
	if k and k.keycode == KEY_5:
		load_map(4)
	if k and k.keycode == KEY_6:
		load_map(5)
	if k and k.keycode == KEY_7:
		load_map(6)
	if k and k.keycode == KEY_8:
		load_map(7)
	if k and k.keycode == KEY_9:
		load_map(8)
	if k and k.keycode == KEY_0:
		load_map(9)
