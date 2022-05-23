extends Node

onready var door = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController
var opening_completed

func enter():
	opening_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	sprite.play("Opening")


func exit(next_state):
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)


func process():
	if opening_completed:
		exit("Closing")


func _on_animation_finished():
	opening_completed = true
