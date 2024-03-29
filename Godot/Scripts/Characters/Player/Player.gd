extends KinematicBody2D

class_name Player

const MAX_LIFE = 3

export var acceleration_camera = 0.25
export var fast_camera = 15
export var slow_camera = 5

export var air_acceleration = 0.05
export var ground_acceleration = 0.05

export var air_deceleration = 0.05
export var ground_deceleration = 0.025

export var strong_gravity = 25
export var weak_gravity = 15
export var terminal_velocity = 1250

export var drop_strength = 50
export var jump_strength = 800

export var run_strength = 300
export var walk_strength = 150

export var throw_strength = 300

onready var bomb_creator = $"Bomb Creator"
onready var camera = $"Camera"
onready var collision_shape = $"Collision Shape"
onready var platform_detector = $"Platform Detector"
onready var sprite = $"Animated Sprite"

var acceleration
var deceleration
var flip
var gravity
var inertia = 5000
var life = 3
var move_strength = 0
var motion = Vector2.ZERO
var on_platform = false


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PLAYER)
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)
	
	LayersUtil.activate_collision(platform_detector, LayersUtil.PLATFORMS_TOP)
	
	var color = Color("#323443")
	VisualServer.set_default_clear_color(color)


func _process(_delta):
	if flip:
		if is_going_left():
			sprite.flip_h = true
			camera.offset_h = -abs(camera.offset_h)
			collision_shape.scale.x = -abs(collision_shape.scale.x)
		elif is_going_right():
			sprite.flip_h = false
			camera.offset_h = abs(camera.offset_h)
			collision_shape.scale.x = abs(collision_shape.scale.x)
	
	if !DPadUtil.player_zoom_out() and !camera.current:
		camera.make_current()


func _physics_process(_delta):
	motion.y += gravity
	motion.y = clamp(motion.y, -INF, terminal_velocity)
	motion = move_and_slide(motion, Vector2.UP)
	if motion.y >= terminal_velocity:
		camera.smoothing_speed += acceleration_camera
		camera.smoothing_speed = clamp(camera.smoothing_speed, slow_camera, fast_camera)
	else:
		camera.smoothing_speed -= acceleration_camera
		camera.smoothing_speed = clamp(camera.smoothing_speed, slow_camera, fast_camera)
	if camera.smoothing_speed > 5:
		print(camera.smoothing_speed)


func is_dead():
	return life <= 0


func is_falling():
	return motion.y > 0


func is_going_left():
	return motion.x <= -0.1


func is_going_right():
	return motion.x >= 0.1


func is_on_platform():
	return on_platform


func is_running():
	return move_strength == run_strength


func is_stopped():
	return abs(motion.x) < move_strength * acceleration


func is_walking():
	return move_strength == walk_strength


func set_air_accel_decel():
	acceleration = air_acceleration
	deceleration = air_deceleration


func set_ground_accel_decel():
	acceleration = ground_acceleration
	deceleration = ground_deceleration


func set_drop_enabled():
	LayersUtil.deactivate_collision(self, LayersUtil.PLATFORMS_TOP)


func set_drop_disabled():
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)


func set_flip_enabled():
	flip = true


func set_flip_disabled():
	flip = false


func set_strong_gravity():
	gravity = strong_gravity


func set_weak_gravity():
	gravity = weak_gravity


func set_run():
	move_strength = run_strength


func set_walk():
	move_strength = walk_strength


func attack():
	bomb_creator.create(position, motion)


func decelerate():
	motion.x = lerp(motion.x, 0, deceleration)


func hit(impact_vector):
	motion.x += impact_vector.x * 750.0
	motion.y += impact_vector.y * 750.0
	life_decrease()


func jump():
	motion.y = - jump_strength


func life_decrease():
	if life > 0:
		life -= 1


func life_increase():
	if life < MAX_LIFE:
		life += 1


func move_left():
	set_flip_enabled()
	motion.x = lerp(motion.x, -move_strength, acceleration)
	motion.x = min(motion.x, - (move_strength * acceleration))


func move_right():
	set_flip_enabled()
	motion.x = lerp(motion.x, move_strength, acceleration)
	motion.x = max(motion.x, move_strength * acceleration)


func _on_platform_entered(body):
	if LayersUtil.is_in_layer(body, LayersUtil.PLATFORMS_TOP):
		on_platform = true


func _on_platform_exited(body):
	if LayersUtil.is_in_layer(body, LayersUtil.PLATFORMS_TOP):
		on_platform = false
