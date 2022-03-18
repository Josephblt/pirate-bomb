class_name Player

extends KinematicBody2D

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

onready var camera = $"Camera"
onready var collision_shape = $"Collision Shape"
onready var left_foot = $"Collision Shape/Left Foot"
onready var right_foot = $"Collision Shape/Right Foot"
onready var sprite = $"Animated Sprite"

var acceleration
var deceleration
var flip
var gravity
var inertia = 5000
var life = 3
var move_strength = 0
var motion = Vector2.ZERO


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PLAYER)
	
	LayersUtil.activate_collision(self, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)
	
	LayersUtil.clear_collisions(left_foot)
	LayersUtil.activate_collision(left_foot, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(left_foot, LayersUtil.PLATFORMS_TOP)
	
	LayersUtil.clear_collisions(right_foot)
	LayersUtil.activate_collision(right_foot, LayersUtil.FOREGROUND)
	LayersUtil.activate_collision(right_foot, LayersUtil.PLATFORMS_TOP)


func _process(_delta):
	if Input.is_action_just_released("player_zoom_out"):
		camera.make_current()
	
	if flip:
		if is_going_left():
			sprite.flip_h = true
			camera.offset_h = -abs(camera.offset_h)
			collision_shape.scale.x = -abs(collision_shape.scale.x)
		elif is_going_right():
			sprite.flip_h = false
			camera.offset_h = abs(camera.offset_h)
			collision_shape.scale.x = abs(collision_shape.scale.x)


func _physics_process(_delta):
	motion.y += gravity
	motion.y = clamp(motion.y, -INF, terminal_velocity)
	motion = move_and_slide(motion, Vector2.UP)


func is_dead():
	return life <= 0


func is_falling():
	return motion.y > 0


func is_going_left():
	return motion.x <= -0.1


func is_going_right():
	return motion.x >= 0.1


func is_on_platform():
	var collider_left = left_foot.get_collider()
	var collider_right = right_foot.get_collider()

	if !collider_left and !collider_right:
		return false

	var left = !collider_left or LayersUtil.is_in_layer(collider_left, LayersUtil.PLATFORMS_TOP)
	var right = !collider_right or LayersUtil.is_in_layer(collider_right, LayersUtil.PLATFORMS_TOP)
	return left and right


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


func decelerate():
	motion.x = lerp(motion.x, 0, deceleration)


func drop():
	LayersUtil.deactivate_collision(self, LayersUtil.PLATFORMS_TOP)


func fall():
	LayersUtil.activate_collision(self, LayersUtil.PLATFORMS_TOP)


func hit(impact_vector, damage):
	motion.x += impact_vector.x
	motion.y += impact_vector.y
	life -= damage


func jump():
	motion.y = - jump_strength


func move_left(multiplier = -1):
	set_flip_enabled()
	motion.x = lerp(motion.x, move_strength * multiplier, acceleration)
	motion.x = min(motion.x, - (move_strength * acceleration))


func move_right(multiplier = 1):
	set_flip_enabled()
	motion.x = lerp(motion.x, move_strength * multiplier, acceleration)
	motion.x = max(motion.x, move_strength * acceleration)
