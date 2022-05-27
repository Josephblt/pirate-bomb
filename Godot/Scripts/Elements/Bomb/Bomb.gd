extends RigidBody2D

onready var interact_emmiter = $"Interact Emitter"

var interact_detector
var layer
var mask


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.BOMB)
	LayersUtil.activate_collision(self, LayersUtil.BOMB)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)
	
	layer = LayersUtil.get_collision_layer(self)
	mask = LayersUtil.get_collision_mask(self)


func _physics_process(_delta):
	if is_instance_valid(interact_detector):
		position = interact_detector.get_parent().position


func destroy():
	queue_free()


func hit(impact_point, impact_vector):
	apply_impulse(impact_point - position, impact_vector)


func interact_start(interactor):
	if is_instance_valid(interactor):
		interact_detector = interactor
		LayersUtil.clear_layers(self)
		LayersUtil.clear_collisions(self)
		mode = RigidBody2D.MODE_STATIC


func interact_end():
	if is_instance_valid(interact_detector):
		LayersUtil.set_collision_layer(self, layer)
		LayersUtil.set_collision_mask(self, mask)
		mode = RigidBody2D.MODE_RIGID
		
		var impulse = _calculate_interact_impulse()
		apply_central_impulse(impulse)
		
		interact_detector = null


func _calculate_interact_impulse():
	var player = interact_detector.get_parent()
	var impulse = player.motion
	if DPadUtil.player_down():
		impulse = Vector2.DOWN * player.throw_strength 
	elif DPadUtil.player_up():
		impulse += Vector2.UP * player.throw_strength
	elif DPadUtil.player_left():
		impulse += Vector2.LEFT * player.throw_strength
	elif DPadUtil.player_right():
		impulse += Vector2.RIGHT * player.throw_strength
	
	
	return impulse
