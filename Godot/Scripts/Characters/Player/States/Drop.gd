extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController
var _drop_completed
var _fall_started


func enter():
	_drop_completed = false
	_fall_started = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	player.set_air_accel_decel()
	player.set_weak_gravity()
	player.set_drop_enabled()
	sprite.play("Drop")


func exit(next_state):
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)
 

func process():
	if hit_detector.is_hit_detected():
		exit("Hit")
	else:
		if Input.is_action_pressed("Player Pick-Throw"):
			pick_detector.attempt_pick_up()
		else:
			pick_detector.attempt_throw_away()
		
		if Input.is_action_just_pressed("Player Bomb") and !pick_detector.is_carrying():
			bomb_creator.create(player.position, player.motion)
	
	if _drop_completed:
		player.set_drop_disabled()
		exit("Fall")


func physics_process():
	if Input.is_action_pressed("Player Walk-Run"):
		player.set_walk()
	else:
		player.set_run()
	
	if DPadUtil.player_move_left_pressed():
		player.move_left()
	elif DPadUtil.player_move_right_pressed():
		player.move_right()
	else:
		player.decelerate()


func _on_animation_finished():
	_drop_completed = true
