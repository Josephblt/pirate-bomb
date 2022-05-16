extends RigidBody2D

onready var hit_detector = $"Hit Detector"


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PROPS)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)
	LayersUtil.activate_collision(self, LayersUtil.PROPS)


func _physics_process(_delta):
	while hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		apply_impulse(hit.impact_point - position, hit.impact_vector)
