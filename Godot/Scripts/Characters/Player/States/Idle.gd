extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var collect_detector = $"../../Collect Detector"
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
		if Input.is_action_pressed("Player Pick-Throw"):
			pick_detector.attempt_pick_up()
		else:
			pick_detector.attempt_throw_away()
		
		if collect_detector.is_collect_detected():
			var collectible_type = collect_detector.fetch_collected_object()
			if collectible_type == Collect.COLLECTIBLE_TYPE.HEART:
				player.life_increase()
		
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
		else:
			exit("Fall")


func physics_process():
	player.decelerate()
