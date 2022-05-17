extends Node

onready var parent = $".."
onready var collision_shape = $"../Collision Shape"
onready var sprite = $"../Animated Sprite"

var collect_area
var collected = false


func _ready():
	collect_area = Area2D.new()
	collect_area.name = "Collect Area"
	collect_area.connect("body_entered", self, "_on_body_entered")
	
	LayersUtil.clear_layers(collect_area)
	LayersUtil.clear_collisions(collect_area)
	LayersUtil.activate_layer(collect_area, LayersUtil.COLLECT)
	LayersUtil.activate_collision(collect_area, LayersUtil.COLLECT)
	
	parent.call_deferred("remove_child", collision_shape)
	collect_area.call_deferred("add_child", collision_shape)
	parent.call_deferred("add_child", collect_area)


func was_collected():
	return collected


func _on_body_entered(body):
	var collect_detector = body.get_node_or_null("Collect Detector")
	if collect_detector:
		collected = true
		collect_detector.collect_detected(parent.COLLECTIBLE_TYPE)
