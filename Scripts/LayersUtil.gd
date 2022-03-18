extends Node

const BOMBS = 0
const FOREGROUND = 1
const HIT = 2
const INTERACT = 3
const PICK = 4
const PLATFORMS = 5
const PLATFORMS_TOP = 6
const PLAYER = 7
const PROPS = 8


func is_in_layer(element, layer_bit):
	return element.get_collision_layer_bit(layer_bit)


func activate_layer(physics_body, layer_bit):
	physics_body.set_collision_layer_bit(layer_bit, true)


func deactivate_layer(physics_body, layer_bit):
	physics_body.set_collision_layer_bit(layer_bit, false)


func activate_collision(physics_body, layer_bit):
	physics_body.set_collision_mask_bit(layer_bit, true)


func deactivate_collision(physics_body, layer_bit):
	physics_body.set_collision_mask_bit(layer_bit, false)


func clear_layers(physics_body):
	physics_body.collision_layer = 0


func clear_collisions(physics_body):
	physics_body.collision_mask = 0


func get_collision_layer(physics_body):
	return physics_body.collision_layer


func get_collision_mask(physics_body):
	return physics_body.collision_mask


func set_collision_layer(physics_body, layers):
	physics_body.collision_layer = layers
	

func set_collision_mask(physics_body, mask):
	physics_body.collision_mask = mask
