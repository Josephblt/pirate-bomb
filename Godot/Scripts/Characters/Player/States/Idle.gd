extends Node

onready var collect_detector = $"../../Collect Detector"
onready var hit_detector = $"../../Hit Detector"
onready var interact_detector = $"../../Interact Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller : StateController


func enter():
	player.set_ground_accel_decel()
	player.set_strong_gravity()
	sprite.play("Idle")


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
		
		if player.is_on_floor():
			if DPadUtil.player_jump(true):
				if DPadUtil.player_down() and player.is_on_platform():
					_exit("Drop")
				else:
					_exit("Jump")
			elif DPadUtil.player_move():
				_exit("Move")
		else:
			_exit("Fall")


func physics_process():
	player.decelerate()


func _exit(next_state):
	sprite.frame = 0
	state_controller.change_to(next_state)
