extends Node

onready var bomb_creator = $"../../Bomb Creator"
onready var collect_detector = $"../../Collect Detector"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_air_accel_decel()
	player.set_strong_gravity()
	sprite.play("Fall")


func exit(next_state):
	sprite.frame = 0
	sprite.speed_scale = 1
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
		
		sprite.speed_scale = abs(player.motion.y / player.terminal_velocity)
		
		if player.is_on_floor():
			exit("Landing")


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
