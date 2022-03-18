extends Node

const Bomb = preload("res://Game Objects/Bomb/Bomb.tscn")

onready var scene_root = $"/root"


func create(position, impulse = Vector2.ZERO):
	var bomb = Bomb.instance()
	bomb.position = position
	bomb.apply_central_impulse(impulse)
	scene_root.add_child(bomb)
	return bomb
