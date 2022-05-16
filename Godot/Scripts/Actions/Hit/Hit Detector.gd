extends Node

onready var parent = $".."

var detected_hits = []


func _ready():
	LayersUtil.activate_layer(parent, LayersUtil.HIT)


func hit_detected(hit):
	detected_hits.append(hit)


func fetch_hit():
	return detected_hits.pop_front()


func is_hit_detected():
	return !detected_hits.empty()
