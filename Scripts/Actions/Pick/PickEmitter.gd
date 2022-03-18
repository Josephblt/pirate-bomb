extends Node

const pick_material = preload("res://Shaders/Pick Material.tres")

export var pick_highlight_color : Color

onready var parent = $".."
onready var collision_shape = $"../Collision Shape"
onready var parent_color = parent.modulate
onready var sprite = $"../Animated Sprite"

var pick_area
var anchor
var parent_layer
var parent_mask


func _ready():
	pick_material.set_shader_param("line_color", pick_highlight_color)
	
	pick_area = Area2D.new()
	pick_area.add_child(collision_shape.duplicate())
	pick_area.connect("body_entered", self, "_on_body_entered")
	pick_area.connect("body_exited", self, "_on_body_exited")
	pick_area.add_child(collision_shape.duplicate())
	
	LayersUtil.clear_layers(pick_area)
	LayersUtil.clear_collisions(pick_area)
	LayersUtil.activate_layer(pick_area, LayersUtil.PICK)
	LayersUtil.activate_collision(pick_area, LayersUtil.PICK)
	
	parent.call_deferred("add_child", pick_area)


func _physics_process(_delta):
	if _is_anchored():
		parent.position = anchor.parent.position


func _on_body_entered(body):
	var pick_detector = body.get_node_or_null("Pick Detector")
	if pick_detector:
		pick_detector.pick_detected(self)


func _on_body_exited(body):
	var pick_detector = body.get_node_or_null("Pick Detector")
	if pick_detector:
		pick_detector.pick_lost(self)


func _is_anchored():
	return is_instance_valid(anchor)


func highlight(flag):
	if flag:
		sprite.material = pick_material
	else:
		sprite.material = null


func pick_up(detector):
	if !_is_anchored():
		anchor = detector
		parent_layer = LayersUtil.get_collision_layer(parent)
		parent_mask = LayersUtil.get_collision_mask(parent)
		LayersUtil.clear_layers(parent)
		LayersUtil.clear_collisions(parent)
		parent.mode = RigidBody2D.MODE_STATIC


func throw_away(impulse = Vector2.ZERO):
	if _is_anchored():
		anchor = null
		LayersUtil.set_collision_layer(parent, parent_layer)
		LayersUtil.set_collision_mask(parent, parent_mask)
		parent.mode = RigidBody2D.MODE_RIGID
		parent.apply_central_impulse(impulse)
