extends RigidBody2D

onready var hit_detector = $"Hit Detector"


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PROPS)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)
	LayersUtil.activate_collision(self, LayersUtil.PROPS)


func _process(_delta):
	if hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		var impact_position = hit[1]
		var impact_vector = hit[2]
		var impulse = hit[3]
		apply_impulse(impact_position - position, impact_vector * impulse)
