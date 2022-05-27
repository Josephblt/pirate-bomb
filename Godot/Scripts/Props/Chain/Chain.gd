extends Node

enum CHAIN_LINK_TYPE { BIG = 0, SMALL = 1}

const CHAIN_LINK_BIG = preload("res://Game/Props/Chain/Chain Link (Big).tscn")
const CHAIN_LINK_SMALL = preload("res://Game/Props/Chain/Chain Link (Small).tscn")

const MIN_LINKS = 5
const MAX_LINKS = 25

onready var chain_anchor_plate = $"Chain Anchor Plate"


func _ready():
	var links = _calculate_links_amount()
	var current_link = chain_anchor_plate
	
	for i in links:
		var link_type = i % 2
		var next_link = _create_link(link_type, current_link)
		_setup_joint(current_link, next_link)
		current_link = next_link


func _calculate_links_amount():
	randomize()
	var links_range = MAX_LINKS - MIN_LINKS + 1
	var links =  MIN_LINKS + (randi() % links_range)
	return links


func _create_link(link_type, current_link):
	var link
	match link_type:
		CHAIN_LINK_TYPE.BIG:
			link = CHAIN_LINK_BIG.instance()
		CHAIN_LINK_TYPE.SMALL:
			link = CHAIN_LINK_SMALL.instance()
	link.position.y = current_link.position.y + 6
	add_child(link)
	return link


func _setup_joint(link_a, link_b):
	var joint = link_a.get_node("Joint")
	joint.node_b = joint.get_path_to(link_b)
	joint.softness = 0.1
	joint.bias = 1.0
