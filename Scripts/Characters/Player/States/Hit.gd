extends Node

onready var animation = $"../../Animation Player"
onready var hit_detector = $"../../Hit Detector"
onready var pick_detector = $"../../Pick Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController
var _hit_completed


func enter():
	_hit_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	player.set_air_accel_decel()
	player.set_strong_gravity()
	pick_detector.attempt_throw_away()
	
	var hit = hit_detector.fetch_hit()
	var impact_vector = hit[0]
	var damage = hit[1]
	player.hit(impact_vector, damage);
	
	if player.is_dead():
		player.set_flip_enabled()
		sprite.play("Dead Hit")
	else:
		player.set_flip_disabled()
		sprite.play("Hit")
		
	var warning_animation = animation.get_animation("Warning")
	warning_animation.loop = true
	animation.play("Warning")


func exit(next_state):
	var warning_animation = animation.get_animation("Warning")
	warning_animation.loop = false
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)
 

func process():
	if !player.is_dead() and hit_detector.is_hit_detected():
		exit("Hit")
	elif _hit_completed:
		if player.is_dead():
			exit("Death")
		elif player.is_on_floor():
			exit("Idle")
		elif player.is_falling():
			exit("Fall")


func physics_process():
	player.decelerate()


func _on_animation_finished():
	_hit_completed = true
