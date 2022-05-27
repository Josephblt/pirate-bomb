	extends Node

onready var collect_detector = $"../../Collect Detector"
onready var hit_detector = $"../../Hit Detector"
onready var interact_detector = $"../../Interact Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_air_accel_decel()
	player.set_strong_gravity()
	sprite.play("Fall")


func process():
	if hit_detector.is_hit_detected():
		_exit("Hit")
	else:
		if DPadUtil.player_interact():
			interact_detector.attempt_interact_start()
		else:
			interact_detector.attempt_interact_end()
		
		if collect_detector.is_collect_detected():
			var collectible_type = collect_detector.fetch_collected_object()
			if collectible_type == Collect.COLLECTIBLE_TYPE.HEART:
				player.life_increase()
		
		if DPadUtil.player_attack() and !interact_detector.is_interacting():
			player.attack()
		
		sprite.speed_scale = abs(player.motion.y / player.terminal_velocity)
		
		if player.is_on_floor():
			_exit("Landing")


func physics_process():
	if DPadUtil.player_walk():
		player.set_walk()
	else:
		player.set_run()
	
	if DPadUtil.player_left():
		player.move_left()
	elif DPadUtil.player_right():
		player.move_right()
	else:
		player.decelerate()


func _exit(next_state):
	sprite.frame = 0
	sprite.speed_scale = 1
	state_controller.change_to(next_state)
