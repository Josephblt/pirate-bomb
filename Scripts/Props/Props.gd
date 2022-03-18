extends RigidBody2D

onready var hit_detector = $"Hit Detector"


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PROPS)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)
	LayersUtil.activate_collision(self, LayersUtil.PROPS)


func _integrate_forces(_state):
	pass
#	if(state.get_contact_count() > 0):
#		print("INTEGRATE FORCES: " + str(state.get_contact_collider(0)))


func _process(_delta):
	if hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		var impact_position = hit[0]
		var impact_vector = hit[1]
		apply_impulse(impact_position, impact_vector)
