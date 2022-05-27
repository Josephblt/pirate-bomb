extends Node

const first_foot_frame = 6
const second_foot_frame = 13
const min_walk_speed_scale = 0.20
const min_run_speed_scale = 1

onready var collect_detector = $"../../Collect Detector"
onready var hit_detector = $"../../Hit Detector"
onready var fx_creator = $"../../FX Creator"
onready var interact_detector = $"../../Interact Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.connect("frame_changed", self, "_on_frame_changed")
	player.set_ground_accel_decel()
	player.set_strong_gravity()


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
			var speed = abs(player.motion.x) / player.move_strength
			if player.is_walking():
				sprite.speed_scale = min_walk_speed_scale + speed
				sprite.play("Walk")
			else:
				sprite.speed_scale = min_run_speed_scale + speed
				sprite.play("Run")
			
			if DPadUtil.player_jump(true):
				if DPadUtil.player_down() and player.is_on_platform():
					_exit("Drop")
				else:
					_exit("Jump")
			elif player.is_stopped():
				_exit("Idle")
		else:
			_exit("Fall")


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


func _create_dust(frame):
	var flip = sprite.flip_h
	var position = player.global_position
	
	if flip:
		if frame == first_foot_frame:
			position += Vector2(14, 0)
		if frame == second_foot_frame:
			position += Vector2(-7, 0)
	else:
		if frame == first_foot_frame:
			position += Vector2(-14, 0)
		if frame == second_foot_frame:
			position += Vector2(7, 0)
	
	fx_creator.create(FXCreator.Effects.RUN, position, sprite.flip_h)


func _exit(next_state):
	sprite.frame = 0
	sprite.speed_scale = 1
	sprite.disconnect("frame_changed", self, "_on_frame_changed")
	state_controller.change_to(next_state)


func _on_frame_changed():
	var speed = abs(player.motion.x) / player.move_strength
	
	if player.is_running() and speed > 0.9:
		if sprite.frame == first_foot_frame or sprite.frame == second_foot_frame:
			_create_dust(sprite.frame)
