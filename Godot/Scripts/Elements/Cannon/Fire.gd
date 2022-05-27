extends Node

onready var cannon = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller : StateController
var fire_completed


func enter():
	fire_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	sprite.connect("frame_changed", self, "_on_frame_changed")
	_fire_cannon_ball()


func process():
	if fire_completed:
		if cannon.on:
			_exit("On")
		else:
			_exit("Off")


func _exit(next_state):
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	sprite.disconnect("frame_changed", self, "_on_frame_changed")
	sprite.frame = 0
	state_controller.change_to(next_state)


func _fire_cannon_ball():
	sprite.play("Fire")


func _on_animation_finished():
	fire_completed = true


func _on_frame_changed():
	if sprite.frame == 5:
		cannon.fire()
