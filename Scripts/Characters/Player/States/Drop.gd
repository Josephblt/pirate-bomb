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
	sprite.connect("frame_changed", self, "_on_frame_changed")
	player.set_air_accel_decel()
	player.set_weak_gravity()
	player.drop()
	sprite.play("Jump")


func exit(next_state):
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	sprite.disconnect("frame_changed", self, "_on_frame_changed")
	state_controller.change_to(next_state)
 

func process():
	if hit_detector.is_hit_detected():
		exit("Hit")
	else:
		if Input.is_action_pressed("player_pick_throw"):
			pick_detector.attempt_pick_up()
		else:
			pick_detector.attempt_throw_away()
		
		if Input.is_action_just_pressed("player_bomb") and !pick_detector.is_carrying():
			bomb_creator.create(player.position, player.motion)
	
	if _drop_completed:
		if player.is_falling():
			exit("Fall")
		elif player.is_on_floor():
			exit("Idle")


func physics_process():
	if Input.is_action_pressed("player_walk_run"):
		player.set_walk()
	else:
		player.set_run()
	
	if Input.is_action_pressed("player_left"):
		player.move_left()
	elif Input.is_action_pressed("player_right"):
		player.move_right()
	else:
		player.decelerate()
	
	if _fall_started:
		player.fall()


func _on_animation_finished():
	_drop_completed = true


func _on_frame_changed():
	_fall_started = true
