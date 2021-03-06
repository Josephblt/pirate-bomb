extends Node

onready var door = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController
var closing_completed

func enter():
	closing_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	sprite.play("Closing")


func process():
	if closing_completed:
		_exit("Closed")


func _exit(next_state):
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	sprite.frame = 0
	state_controller.change_to(next_state)


func _on_animation_finished():
	closing_completed = true
