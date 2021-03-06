extends Node

onready var heart = $"../.."
onready var emitter = $"../../Collect Emitter"
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	sprite.play("Spawn")


func process():
	if emitter.was_collected():
		_exit("Collected")


func _exit(next_state):
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)


func _on_animation_finished():
	_exit("Idle")
