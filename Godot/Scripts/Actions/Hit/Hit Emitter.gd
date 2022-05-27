extends Node

const MIN_BLAST_DISTANCE = .25

onready var parent = $".."
onready var collision_shape = $"../Collision Shape"

export var impulse = 350

var bodies = []
var hit_area


func _ready():
	hit_area = Area2D.new()
	hit_area.name = "Hit Area"
	hit_area.connect("body_entered", self, "_on_body_entered")
	
	LayersUtil.clear_layers(hit_area)
	LayersUtil.clear_collisions(hit_area)
	LayersUtil.activate_layer(hit_area, LayersUtil.HIT)
	LayersUtil.activate_collision(hit_area, LayersUtil.HIT)
	
	parent.call_deferred("remove_child", collision_shape)
	hit_area.call_deferred("add_child", collision_shape)
	parent.call_deferred("add_child", hit_area)


func _broadcast_hit(body, impact_point, impact_vector):
	var emitter_point = parent.global_position
	var hit_detector = body.get_node("Hit Detector")
	var hit = Hit.new(emitter_point, impact_point, impact_vector)
	hit_detector.hit_detected(hit)


func _calculate_impact_point(body):
	var body_s = body.shape_owner_get_shape(0, 0)
	var area_s = hit_area.shape_owner_get_shape(0, 0)
	
	var body_t = body.global_transform
	var area_t = hit_area.global_transform
	
	var contacts = area_s.collide_and_get_contacts(area_t, body_s, body_t)
	var nearest_point = body.global_position
	var nearest_distance = nearest_point.distance_to(parent.global_position)
	
	for contact in contacts:
		var distance = contact.distance_to(parent.global_position)
		if distance < nearest_distance:
			nearest_point = contact
			nearest_distance = distance
	
	return nearest_point


func _calculate_impact_vector(impact_point):
	var impact_direction = parent.global_position.direction_to(impact_point)
	return impact_direction * impulse


func _on_body_entered(body):
	if !bodies.has(body):
		bodies.append(body)
		var impact_point = _calculate_impact_point(body)
		var impact_vector = _calculate_impact_vector(impact_point)
		_broadcast_hit(body, impact_point, impact_vector)
