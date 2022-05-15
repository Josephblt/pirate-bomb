extends Node2D

const Player = preload("res://Game Objects/Characters/Player.tscn")

export var spawn_on_start = true

onready var door = $"Door"
onready var scene_root = $"/root"


func _ready():
	if spawn_on_start:
		spawn()


func spawn():
	var player = Player.instance()
	player.position = position
	scene_root.call_deferred("add_child", player)
	door.open()
