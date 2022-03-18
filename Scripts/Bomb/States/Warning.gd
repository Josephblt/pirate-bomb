extends Node

onready var animation = $"../../Animation Player"
onready var bomb = $"../.."
onready var hit_detector = $"../../Hit Detector"
onready var explosion_creator = $"../../Explosion Creator"
onready var sprite = $"../../Animated Sprite"
onready var timer = $Timer

var state_controller : StateController


func enter():
	timer.connect("timeout", self, "_on_timeout")
	sprite.play("On")
	animation.play("Warning")
	timer.start()


func exit(next_state):
	timer.disconnect("timeout", self, "_on_timeout")
	timer.stop()
	state_controller.change_to(next_state)


func process():
	if hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		while hit:
			var impact_vector = hit[0]
			var damage = hit[1]
			bomb.hit(impact_vector, damage);
			hit = hit_detector.fetch_hit()
	
	var playback_increase = 1 - (timer.time_left / timer.wait_time)
	playback_increase *= 3
	animation.playback_speed = 1 + playback_increase


func _on_timeout():
	explosion_creator.create(bomb.global_position)
	bomb.destroy()
