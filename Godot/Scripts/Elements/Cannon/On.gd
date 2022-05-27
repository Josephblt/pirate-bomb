extends Node

const MIN_WAIT_TIME = 0.001

onready var cannon = $"../.."
onready var sprite = $"../../Animated Sprite"
onready var timer = $"Timer"

var state_controller: StateController


func enter():
	sprite.play("Idle")
	
	timer.wait_time = cannon.fire_timer_wait_time
	if timer.wait_time < MIN_WAIT_TIME:
		timer.wait_time = MIN_WAIT_TIME
		
	timer.connect("timeout", self, "_on_timeout")
	timer.start()


func process():
	if !cannon.on:
		_exit("Off")


func _on_timeout():
	_exit("Fire")


func _exit(next_state):
	timer.disconnect("timeout", self, "_on_timeout")
	timer.stop()
	state_controller.change_to(next_state)
