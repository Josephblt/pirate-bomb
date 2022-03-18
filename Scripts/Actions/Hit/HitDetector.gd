extends Node

class_name Hit_Detector

onready var parent = $".."

var detected_hits = []


func _ready():
	LayersUtil.activate_layer(parent, LayersUtil.HIT)


func hit_detected(impact_position, impact_vector, damage):
	print("HIT DETECTED")
	detected_hits.append([impact_position, impact_vector, damage])


func fetch_hit():
	return detected_hits.pop_front()


func is_hit_detected():
	return !detected_hits.empty()
