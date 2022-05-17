 extends Node

onready var parent = $".."

var detected_interacts = []
var interacted_object 


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


func _sort_by_distance(pickA, pickB):
	var distanceA = parent.position.distance_to(pickA.parent.position)
	var distanceB = parent.position.distance_to(pickB.parent.position)
	return distanceA < distanceB


func _is_interact_detected():
	return !detected_interacts.empty()


func is_interacting():
	return is_instance_valid(interacted_object)


func interact_detected(emmiter):
	detected_interacts.append(emmiter)


func interact_lost(emmiter):
	var index = detected_interacts.find_last(emmiter)
	emmiter.highlight(false)
	detected_interacts.remove(index)


func attempt_interaction():
	if _is_interact_detected() and !is_interacting():
		interacted_object = detected_interacts.front()
		interacted_object.interact(self)

