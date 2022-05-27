extends Node

const interact_material = preload("res://Shaders/Interact Material.tres")

export var highlight_color : Color

onready var parent = $".."
onready var collision_shape = $"../Collision Shape"
onready var sprite = $"../Animated Sprite"


func _ready():
	interact_material.set_shader_param("line_color", highlight_color)
	
	var interact_area = Area2D.new()
	interact_area.name = "Interact Area"
	interact_area.connect("body_entered", self, "_on_body_entered")
	interact_area.connect("body_exited", self, "_on_body_exited")
	
	LayersUtil.clear_layers(interact_area)
	LayersUtil.clear_collisions(interact_area)
	LayersUtil.activate_layer(interact_area, LayersUtil.INTERACT)
	LayersUtil.activate_collision(interact_area, LayersUtil.INTERACT)
	
	interact_area.call_deferred("add_child", collision_shape.duplicate())
	parent.call_deferred("add_child", interact_area)


func _on_body_entered(body):
	var interact_detector = body.get_node_or_null("Interact Detector")
	if interact_detector:
		interact_detector.interact_detected(self)


func _on_body_exited(body):
	var interact_detector = body.get_node_or_null("Interact Detector")
	if interact_detector:
		interact_detector.interact_lost(self)


func highlight(flag):
	if flag:
		sprite.material = interact_material
	else:
		sprite.material = null


func interact_start(interact_detector):
	parent.interact_start(interact_detector)


func interact_end():
	parent.interact_end()
