extends RigidBody2D

const MIN_GRAVITY = 0
const MAX_GRAVITY = 1

onready var collision_shape = $"Collision Shape"
onready var hit_emmiter_collision_shape = $"Impact/Collision Shape"


func destroy():
	queue_free()


func hit(impact_point, impact_vector):
	apply_impulse(impact_point - position, impact_vector)


func set_collision_off():
	LayersUtil.clear_layers(self)
	LayersUtil.clear_collisions(self)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)


func set_collision_on():
	LayersUtil.clear_layers(self)
	LayersUtil.clear_collisions(self)
	LayersUtil.activate_layer(self, LayersUtil.CANNON_BALL)
	LayersUtil.activate_collision(self, LayersUtil.BOMB)
	LayersUtil.activate_collision(self, LayersUtil.CANNON_BALL)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS)


func set_hit_off():
	hit_emmiter_collision_shape.disabled = true


func set_hit_on():
	hit_emmiter_collision_shape.disabled = false


func set_max_gravity():
	gravity_scale = MAX_GRAVITY


func set_min_gravity():
	gravity_scale = MIN_GRAVITY
