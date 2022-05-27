extends Node

onready var cannon = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.play("Idle")


func process():
	if cannon.on:
		_exit("On")


func _exit(next_state):
	state_controller.change_to(next_state)
