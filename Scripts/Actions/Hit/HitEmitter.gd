extends Area2D

onready var parent = $".."

export var impulse = 500
export var damage = 1

var contact_collider_position
var local_collider_position


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.HIT)
	LayersUtil.activate_collision(self, LayersUtil.HIT)


#func _integrate_forces(state):
#	if(state.get_contact_count() > 0):
#		contact_collider_position = state.get_contact_collider_position(0)
#		local_collider_position = state.get_contact_local_position(0)
##		var impact_position = contact_collider_position
##		var impact_vector = local_collider_position.normalized() * impulse


func _on_body_entered(body):
	var hit_detector = body.get_node_or_null("Hit Detector")
	if hit_detector:
		if local_collider_position and contact_collider_position:
			var impact_position = contact_collider_position
			var impact_vector = local_collider_position.normalized() * impulse
			hit_detector.hit_detected(impact_position, impact_vector, damage)

