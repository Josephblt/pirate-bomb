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
		if Input.is_action_pressed("player_pick_throw"):
				pick_detector.attempt_pick_up()
		elif Input.is_action_just_released("player_pick_throw"):
			pick_detector.attempt_throw_away()
			
		if Input.is_action_just_pressed("player_bomb") and !pick_detector.is_carrying():
			bomb_creator.create(player.position, player.motion)
		
		if player.is_on_floor():
			if Input.is_action_just_pressed("player_jump"):
				if Input.is_action_pressed("player_down"):
					if player.is_on_platform():
						exit("Drop")
				else:
					exit("Jump")
			elif Input.is_action_pressed("player_left") || Input.is_action_pressed("player_right"):
				exit("Move")
			elif player.is_stopped():
				exit("Idle")
		else:
			exit("Fall")


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
