extends Node

onready var bomb = $"../.."
onready var hit_detector = $"../../Hit Detector"
onready var sprite = $"../../Animated Sprite"
onready var timer = $Timer

var state_controller: StateController


func enter():
	timer.connect("timeout", self, "_on_timeout")
	sprite.play("On")
	timer.start()


func exit(next_state):
	timer.disconnect("timeout", self, "_on_timeout")
	timer.stop()
	state_controller.change_to(next_state)


func process():
	var was_hit = false
	
	while hit_detector.is_hit_detected():
		was_hit = true
		var hit = hit_detector.fetch_hit()
		bomb.hit(hit.impact_point, hit.impact_vector);

	if was_hit:
		exit("Warning")


func _on_timeout():
	exit("Warning")
