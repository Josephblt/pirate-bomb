extends RigidBody2D


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.BOMBS)
	LayersUtil.activate_collision(self, LayersUtil.BOMBS)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)


func destroy():
	queue_free()


func hit(impact_point, impact_vector):
	apply_impulse(impact_point - position, impact_vector)
