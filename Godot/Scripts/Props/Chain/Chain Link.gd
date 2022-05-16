extends RigidBody2D

const MAX_IMPULSE = 75

onready var hit_detector = $"Hit Detector"
onready var joint = $"Joint"


func _ready():
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)


func _physics_process(_delta):
	while hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		var impact_vector = hit.impact_vector
		var magnitude = impact_vector.length()
		if magnitude > MAX_IMPULSE:
			impact_vector = impact_vector.normalized() * MAX_IMPULSE
		apply_impulse(hit.impact_point - position, impact_vector)
