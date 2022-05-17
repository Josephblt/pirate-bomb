extends Node

onready var heart = $"../.."
onready var emitter = $"../../Collect Emitter"
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.play("Idle")


func exit(next_state):
	state_controller.change_to(next_state)


func process():
	if emitter.was_collected():
		exit("Collected")
