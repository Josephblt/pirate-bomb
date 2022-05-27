extends Node2D

const Player = preload("res://Game/Characters/Player.tscn")

export var spawn_on_start = true

onready var door = $"Door"
onready var scene_root = $"/root"

var player


func _ready():
	if spawn_on_start:
		spawn()


func spawn():
	player = Player.instance()
	player.position = position
	player.connect("tree_exiting", self, "_on_tree_exiting")
	scene_root.call_deferred("add_child", player)
	door.open()


func _on_tree_exiting():
	player.disconnect("tree_exiting", self, "_on_tree_exiting")
	spawn()
