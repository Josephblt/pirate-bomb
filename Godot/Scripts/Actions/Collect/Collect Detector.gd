extends Node

onready var parent = $".."

var detected_collects = []


func _ready():
	LayersUtil.activate_layer(parent, LayersUtil.COLLECT)


func is_collect_detected():
	return !detected_collects.empty()


func fetch_collected_object():
	if is_collect_detected():
		return detected_collects.pop_front()


func collect_detected(collectible_type):
	detected_collects.append(collectible_type)
