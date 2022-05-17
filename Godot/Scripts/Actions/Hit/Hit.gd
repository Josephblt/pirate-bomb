class_name Hit

var emitter_point: Vector2
var impact_point: Vector2
var impact_vector: Vector2
var damage: int

func _init(init_emitter_point, init_impact_point, init_impact_vector):
	self.emitter_point = init_emitter_point
	self.impact_point = init_impact_point
	self.impact_vector = init_impact_vector
