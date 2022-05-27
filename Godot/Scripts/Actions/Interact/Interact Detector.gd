extends Node

onready var parent = $".."

var detected_interacts = []
var interact_emmiter


func _ready():
	LayersUtil.activate_layer(parent, LayersUtil.INTERACT)


func _process(_delta):
	detected_interacts.sort_custom(self, "_sort_by_distance")
	
	for emitter in detected_interacts:
		emitter.highlight(false)
	
	if !is_interacting():
		if !detected_interacts.empty():
			var closest_emitter = detected_interacts.front()
			closest_emitter.highlight(true)


func _sort_by_distance(interactA, interactB):
	var distanceA = parent.position.distance_to(interactA.parent.position)
	var distanceB = parent.position.distance_to(interactB.parent.position)
	return distanceA < distanceB


func _is_interact_detected():
	return !detected_interacts.empty()


func is_interacting():
	return is_instance_valid(interact_emmiter)


func interact_detected(emmiter):
	detected_interacts.append(emmiter)


func interact_lost(interactable):
	var index = detected_interacts.find_last(interactable)
	interactable.highlight(false)
	detected_interacts.remove(index)
	attempt_interact_end()


func attempt_interact_start():
	if _is_interact_detected() and !is_interacting():
		interact_emmiter = detected_interacts.front()
		interact_emmiter.interact_start(self)


func attempt_interact_end():
	if is_interacting():
		interact_emmiter.interact_end()
		interact_emmiter = null
