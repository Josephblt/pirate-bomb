extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var fx_creator = $"../../FX Creator"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_air_accel_decel()
	player.set_weak_gravity()
	player.jump()
	sprite.play("Jump")
	_create_dust()


func exit(next_state):
	sprite.frame = 0
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
		
		if player.is_falling():
			exit("Fall")


func physics_process():
	if Input.is_action_pressed("Player Walk-Run"):
		player.set_walk()
	else:
		player.set_run()
		
	if Input.is_action_just_released("Player Jump"):
		player.set_strong_gravity()
	
	if DPadUtil.player_move_left_pressed():
		player.move_left()
	elif DPadUtil.player_move_right_pressed():
		player.move_right()
	else:
		player.decelerate()


func _create_dust():
	var flip = sprite.flip_h
	var position = player.global_position
	
	if flip:
		position += Vector2(-4, 0)
	else:
		position += Vector2(4, 0)
	
	fx_creator.create(FXCreator.Effects.JUMP, position, sprite.flip_h)
