extends Node

signal closed
signal opened

onready var sprite = $"Animated Sprite"

var open_requested


func is_open_requested():
	return open_requested


func open():
	open_requested = true


func _on_animation_finished():
	match sprite.animation:
		"Closing":
			emit_signal("closed")
		"Opening":
			emit_signal("opened")
