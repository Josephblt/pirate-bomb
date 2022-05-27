extends Node

onready var collect_detector = $"../../Collect Detector"
onready var fx_creator = $"../../FX Creator"
onready var hit_detector = $"../../Hit Detector"
onready var interact_detector = $"../../Interact Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	player.set_air_accel_decel()
	player.set_weak_gravity()
	player.jump()
	sprite.play("Jump")
	_create_dust()


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
		
		if player.is_falling():
			_exit("Fall")


func physics_process():
	if !DPadUtil.player_jump():
		player.set_strong_gravity()
	
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


func _create_dust():
	var flip = sprite.flip_h
	var position = player.global_position
	
	if flip:
		position += Vector2(-4, 0)
	else:
		position += Vector2(4, 0)
	
	fx_creator.create(FXCreator.Effects.JUMP, position, sprite.flip_h)


func _exit(next_state):
	sprite.frame = 0
	state_controller.change_to(next_state)
