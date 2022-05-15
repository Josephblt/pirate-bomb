extends Node

class_name StateController

export var debug = true
export var default_state = "Unknown"

var state: Object


func _ready():
	state = get_node(default_state)
	_enter_state()


func _enter_state():
	if debug:
		print("Entering state: ", state.name)
	state.state_controller = self
	state.enter()


func _process(_delta):
	if state.has_method("process"):
		state.process()


func _physics_process(_delta):
	if state.has_method("physics_process"):
		state.physics_process()


func change_to(new_state):
	state = get_node(new_state)
	_enter_state()


func destroy():
	get_parent().queue_free()
