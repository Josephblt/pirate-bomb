extends Node

const Explosion = preload("res://Game/Elements/Bomb/Explosion.tscn")

onready var scene_root = $"/root"


func create(position):
	var explosion = Explosion.instance()
	explosion.position = position
	scene_root.add_child(explosion)
	return explosion
