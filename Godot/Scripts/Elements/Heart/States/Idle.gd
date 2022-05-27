extends Node

onready var heart = $"../.."
onready var emitter = $"../../Collect Emitter"
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.play("Idle")


func process():
	if emitter.was_collected():
		_exit("Collected")


func _exit(next_state):
	state_controller.change_to(next_state)
