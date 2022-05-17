extends Node2D

const Heart = preload("res://Game Objects/Heart/Heart.tscn")

onready var scene_root = $"/root"
onready var timer = $"Timer"

var heart

func _ready():
	create()


func create():
	timer.stop()
	
	heart = Heart.instance()
	heart.position = position
	heart.connect("tree_exiting", self, "_on_tree_exiting")
	scene_root.call_deferred("add_child", heart)


func _on_tree_exiting():
	heart.disconnect("tree_exiting", self, "_on_tree_exiting")
	timer.start()


func _on_timer_timeout():
	create()
