extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller : StateController


func enter():
	player.set_ground_accel_decel()
	player.set_strong_gravity()
	sprite.play("Idle")


func exit(next_state):
	sprite.frame = 0
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
		
		if player.is_on_floor():
			if Input.is_action_just_pressed("player_jump"):
				if Input.is_action_pressed("player_down") and player.is_on_platform():
						exit("Drop")
				else:
					exit("Jump")
			elif Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
				exit("Move")
		else:
			exit("Fall")


func physics_process():
	player.decelerate()

