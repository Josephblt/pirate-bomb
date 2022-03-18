extends Node

onready var door = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.play("Closed")


func exit(next_state):
	state_controller.change_to(next_state)


func _process(_delta):
	if door.is_open_requested():
		door.open_requested = false
		exit("Opening")
