extends Node

onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller : StateController
var enter_completed


func enter():
	enter_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	player.set_ground_accel_decel()
	player.set_strong_gravity()
	sprite.play("Enter")


func process():
	if enter_completed:
		_exit("Idle")


func _exit(next_state):
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)


func _on_animation_finished():
	enter_completed = true
