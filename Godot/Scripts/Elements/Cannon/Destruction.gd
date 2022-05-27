extends Node

onready var cannon = $"../.."
onready var animation = $"../../Animation Player"
onready var hit_detector = $"../../Hit Detector"
onready var timer = $"Timer"


var state_controller: StateController


func enter():
	animation.play("Destruction")
	cannon.call_deferred("set_max_gravity")
	cannon.call_deferred("set_hit_off")
	timer.connect("timeout", self, "_on_timeout")
	timer.start()


func process():
	while hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		cannon.hit(hit.impact_point, hit.impact_vector);


func _exit(next_state):
	timer.disconnect("timeout", self, "_on_timeout")
	timer.stop()
	state_controller.change_to(next_state)


func _on_timeout():
	cannon.destroy()
	
