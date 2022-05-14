extends Node

const first_foot_frame = 6
const second_foot_frame = 13
const min_walk_speed_scale = 0.20
const min_run_speed_scale = 1

onready var bomb_creator = $"../../Bomb Creator"
onready var hit_detector = $"../../Hit Detector"
onready var fx_creator = $"../../FX Creator"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.connect("frame_changed", self, "_on_frame_changed")
	player.set_ground_accel_decel()
	player.set_strong_gravity()


func exit(next_state):
	sprite.frame = 0
	sprite.speed_scale = 1
	sprite.disconnect("frame_changed", self, "_on_frame_changed")
	state_controller.change_to(next_state)


func process():
	if hit_detector.is_hit_detected():
		exit("Hit")
	else:
		if Input.is_action_just_pressed("Player Pick-Throw"):
			pick_detector.attempt_pick_up()
		else:
			pick_detector.attempt_throw_away()
			
		if Input.is_action_just_pressed("Player Bomb") and !pick_detector.is_carrying():
			bomb_creator.create(player.position, player.motion)
		
		if player.is_on_floor():
			var speed = abs(player.motion.x) / player.move_strength
			if player.is_walking():
				sprite.speed_scale = min_walk_speed_scale + speed
				sprite.play("Walk")
			else:
				sprite.speed_scale = min_run_speed_scale + speed
				sprite.play("Run")
			
			if Input.is_action_just_pressed("Player Jump"):
				if DPadUtil.player_move_down_pressed() and player.is_on_platform():
					exit("Drop")
				else:
					exit("Jump")
			elif player.is_stopped():
				exit("Idle")
		else:
			exit("Fall")


func physics_process():
	var multiplier = 1
	if Input.is_action_pressed("Player Walk-Run"):
		multiplier = _calculate_walk_multiplier()
		player.set_walk()
	else:
		player.set_run()
	
	if DPadUtil.player_move_left_pressed():
		player.move_left(multiplier)
	elif DPadUtil.player_move_right_pressed():
		player.move_right(multiplier)
	else:
		player.decelerate()


func _calculate_walk_multiplier():
	var digital_multiplier = abs(Input.get_axis("Player Left", "Player Right"))
	var analog_multiplier = Input.get_axis("Player Left (Analog)", "Player Right (Analog)")
	
	if abs(analog_multiplier) > abs(digital_multiplier):
		return analog_multiplier
	else:
		return digital_multiplier


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


func _on_frame_changed():
	var speed = abs(player.motion.x) / player.move_strength
	
	if player.is_running() and speed > 0.9:
		if sprite.frame == first_foot_frame or sprite.frame == second_foot_frame:
			_create_dust(sprite.frame)
