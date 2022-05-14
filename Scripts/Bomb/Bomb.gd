extends RigidBody2D


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.BOMBS)
	LayersUtil.activate_collision(self, LayersUtil.BOMBS)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)


func destroy():
	queue_free()


func hit(impact_position, impact_vector, impulse):
	apply_impulse(impact_position - position, impact_vector * impulse)
