extends Node

onready var cannon = $"../.."
onready var hit_detector = $"../../Hit Detector"


var state_controller: StateController


func enter():
	cannon.call_deferred("set_min_gravity")
	cannon.call_deferred("set_collision_on")
	cannon.call_deferred("set_hit_on")
	cannon.connect("body_entered", self, "_on_body_entered")


func process():
	var was_hit = false
	
	while hit_detector.is_hit_detected():
		was_hit = true
		var hit = hit_detector.fetch_hit()
		cannon.hit(hit.impact_point, hit.impact_vector);

	if was_hit:
		_exit("Destruction")


func _exit(next_state):
	cannon.disconnect("body_entered", self, "_on_body_entered")
	state_controller.change_to(next_state)


func _on_body_entered(_body):
	_exit("Destruction")
