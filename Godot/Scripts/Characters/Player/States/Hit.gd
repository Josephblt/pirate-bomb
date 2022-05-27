extends Node

onready var animation = $"../../Animation Player"
onready var hit_detector = $"../../Hit Detector"
onready var interact_detector = $"../../Interact Detector"
onready var player = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController
var hit_completed


func enter():
	hit_completed = false
	sprite.connect("animation_finished", self, "_on_animation_finished")
	player.set_air_accel_decel()
	player.set_strong_gravity()
	interact_detector.attempt_interact_end()
	
	var hit = hit_detector.fetch_hit()
	var impact_vector = hit.emitter_point.direction_to(player.position)
	player.hit(impact_vector);
	
	if player.is_dead():
		player.set_flip_enabled()
		sprite.play("Dead Hit")
	else:
		player.set_flip_disabled()
		sprite.play("Hit")
		
	var warning_animation = animation.get_animation("Warning")
	warning_animation.loop = true
	animation.play("Warning")


func process():
	if !player.is_dead() and hit_detector.is_hit_detected():
		_exit("Hit")
	elif hit_completed:
		if player.is_dead():
			_exit("Death")
		elif player.is_on_floor():
			_exit("Idle")
		elif player.is_falling():
			_exit("Fall")


func physics_process():
	player.decelerate()


func _exit(next_state):
	var warning_animation = animation.get_animation("Warning")
	warning_animation.loop = false
	sprite.frame = 0
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	state_controller.change_to(next_state)


func _on_animation_finished():
	hit_completed = true
