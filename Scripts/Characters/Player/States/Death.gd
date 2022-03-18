extends Node

onready var animation = $"../../Animation Player"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_flip_enabled()
	player.set_ground_accel_decel()
	player.set_strong_gravity()
	pick_detector.attempt_throw_away()
	
	sprite.play("Death")
	yield(sprite, "animation_finished")
	animation.play("Destruction")
	yield(animation, "animation_finished")
	state_controller.destroy()


func physics_process():
	player.decelerate()
