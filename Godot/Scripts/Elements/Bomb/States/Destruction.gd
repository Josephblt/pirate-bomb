extends Node

onready var bomb = $"../.."
onready var animation = $"../../Animation Player"
onready var hit_detector = $"../../Hit Detector"
onready var sprite = $"../../Animated Sprite"
onready var timer = $Timer

var state_controller: StateController


func enter():
	timer.connect("timeout", self, "_on_timeout")
	sprite.play("Off")
	animation.play("Destruction")
	timer.start()


func process():
	while hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		bomb.hit(hit.impact_point, hit.impact_vector);
	
	var playback_increase = 1 - (timer.time_left / timer.wait_time)
	playback_increase *= 3
	animation.playback_speed = 1 + playback_increase


func _on_timeout():
	bomb.destroy()
