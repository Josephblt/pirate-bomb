extends Node2D

onready var door = $"Door"
onready var scene_root = $"/root"


func spawn():
	door.open()
