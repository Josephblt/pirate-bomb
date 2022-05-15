extends Node

onready var parent = $".."
onready var collision_shape = $"../Collision Shape"
onready var sprite = $"../Animated Sprite"

export var impulse = 350
export var damage = 1

var bodies: Dictionary = {}
var hit_area

func _ready():
	hit_area = Area2D.new()
	hit_area.name = "Hit Area"
	hit_area.connect("body_shape_entered", self, "_on_body_shape_entered")
	
	LayersUtil.clear_layers(hit_area)
	LayersUtil.clear_collisions(hit_area)
	LayersUtil.activate_layer(hit_area, LayersUtil.HIT)
	LayersUtil.activate_collision(hit_area, LayersUtil.HIT)
	
	parent.call_deferred("remove_child", collision_shape)
	hit_area.call_deferred("add_child", collision_shape)
	parent.call_deferred("add_child", hit_area)


func _physics_process(_delta):
	for key in bodies:
		if bodies[key]:
			var body = bodies[key][0]
			var body_shape = bodies[key][1]
			var area_shape = bodies[key][2]
			
			var body_shape2d = body.shape_owner_get_shape(body_shape, 0)
			var area_shape2d = hit_area.shape_owner_get_shape(area_shape, 0)
			
			var body_shape2d_transform = body.global_transform
			var area_shape2d_transform = hit_area.global_transform
				
			var collision_points = area_shape2d.collide_and_get_contacts(area_shape2d_transform, body_shape2d, body_shape2d_transform)
			var emitter_point = parent.position
			var impact_point = body.position
			var impact_distance = impact_point.distance_to(parent.position)
					
			for point in collision_points:
				var distance = point.distance_to(parent.position)
				if distance < impact_distance:
					impact_point = point
					impact_distance = distance
				
			var impact_vector = parent.position.direction_to(impact_point)
			bodies[key] = null
				
			var hit_detector = body.get_node("Hit Detector")
			hit_detector.hit_detected(emitter_point, impact_point, impact_vector, impulse, damage)


func _on_body_shape_entered(id, body, body_shape, area_shape):
	if body != null:
		var key = str(body)
		if !bodies.has(key):
			bodies[key] = [body, body_shape, area_shape, id]
