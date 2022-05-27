extends Node

onready var door = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.play("Closed")


func process():
	if door.is_open_requested():
		door.open_requested = false
		_exit("Opening")


func _exit(next_state):
	state_controller.change_to(next_state)
