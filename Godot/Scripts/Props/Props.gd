tool
extends RigidBody2D

export var inverted = false setget _invert

onready var collision_shape = $"Collision Shape"
onready var hit_detector = $"Hit Detector"
onready var sprite = $"Sprite"


var original_collision_shape_scale
var original_sprite_flip_h


func _ready():
	if not Engine.editor_hint:
		_invert(inverted)
		LayersUtil.activate_layer(self, LayersUtil.PROPS)
		LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
		LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)
		LayersUtil.activate_collision(self, LayersUtil.PROPS)


func _physics_process(_delta):
	if not Engine.editor_hint:
		while hit_detector.is_hit_detected():
			var hit = hit_detector.fetch_hit()
			apply_impulse(hit.impact_point - position, hit.impact_vector)


func _invert(new_inverted):
	var collision_shape_node = get_node("Collision Shape")
	var sprite_node = get_node("Sprite")
	
	if collision_shape_node and sprite_node:
		if !inverted:
			original_collision_shape_scale = collision_shape_node.scale
			original_sprite_flip_h = sprite_node.flip_h
		else:
			original_collision_shape_scale = collision_shape_node.scale * Vector2(-1, 1)
			original_sprite_flip_h = !sprite_node.flip_h
		
		if !new_inverted:
			collision_shape_node.scale = original_collision_shape_scale
			sprite_node.flip_h = original_sprite_flip_h
		else:
			collision_shape_node.scale = original_collision_shape_scale * Vector2(-1, 1)
			sprite_node.flip_h = !original_sprite_flip_h
	
	inverted = new_inverted
