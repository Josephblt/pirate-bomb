extends RigidBody2D

onready var hit_detector = $"Hit Detector"
onready var joint = $"Joint"

func _ready():
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)

func _physics_process(_delta):
	if hit_detector.is_hit_detected():
		var hit = hit_detector.fetch_hit()
		var impact_position = hit[1]
		var impact_vector = hit[2]
		var impulse = clamp(hit[3], 0, 75)
		apply_impulse(impact_position - position, impact_vector * impulse)
