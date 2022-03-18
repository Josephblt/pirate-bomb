extends Node

onready var parent = $".."

var detected_picks = []
var picked_object 


func _ready():
	LayersUtil.activate_layer(parent, LayersUtil.PICK)


func _process(_delta):
	detected_picks.sort_custom(self, "_sort_by_distance")
	
	for emitter in detected_picks:
			emitter.highlight(false)
	
	if !is_carrying():
		if !detected_picks.empty():
			var closest_emitter = detected_picks.front()
			closest_emitter.highlight(true)


func _sort_by_distance(pickA, pickB):
	var distanceA = parent.position.distance_to(pickA.parent.position)
	var distanceB = parent.position.distance_to(pickB.parent.position)
	return distanceA < distanceB


func _is_pick_detected():
	return !detected_picks.empty()


func is_carrying():
	return is_instance_valid(picked_object)


func pick_detected(emmiter):
	detected_picks.append(emmiter)


func pick_lost(emmiter):
	var index = detected_picks.find_last(emmiter)
	emmiter.highlight(false)
	detected_picks.remove(index)


func attempt_pick_up():
	if _is_pick_detected() and !is_carrying():
		picked_object = detected_picks.front()
		picked_object.pick_up(self)


func attempt_throw_away():
	if is_carrying():
		picked_object.throw_away(parent.motion)
		picked_object = null
