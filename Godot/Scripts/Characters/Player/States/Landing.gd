extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var fx_creator = $"../../FX Creator"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_ground_accel_decel()
	player.set_strong_gravity()
	sprite.play("Landing")
	fx_creator.create(FXCreator.Effects.LANDING, player.global_position, sprite.flip_h)


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
		
		if player.is_on_floor():
			if Input.is_action_just_pressed("Player Jump"):
				if DPadUtil.player_move_down_pressed() and player.is_on_platform():
					exit("Drop")
				else:
					exit("Jump")
			elif DPadUtil.player_move_horizontal_pressed():
				exit("Move")
			elif player.is_stopped():
				exit("Idle")
		else:
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
