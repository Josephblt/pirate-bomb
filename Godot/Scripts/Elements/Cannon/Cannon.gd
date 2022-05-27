tool
extends Node2D

const FIRE_TIMER_MAX_PERCENTAGE = 10
const FIRE_TIMER_MIN_PERCENTAGE = 0
const FIRE_TIMER_OFF_PERCENTAGE = -1

export var fire_timer_max = 10
export var fire_timer_min = 5
export var inverted = false setget _invert
var impulse = 750.0
export var on = true

onready var cannon_ball_creator = $"Cannon Ball Creator"
onready var interact_emmiter = $"Interact Emitter"
onready var bar_sprite = $"Bar Sprite"

var direction = Vector2.LEFT
var fire_timer_percentage = 10
var fire_timer_wait_time = 0
var interact_detector
var original_collision_shape_scale
var original_sprite_flip_h


func _ready():
	if not Engine.editor_hint:
		_invert(inverted)
		fire_timer_wait_time = _calculate_wait_time()


func _process(_delta):
	if not Engine.editor_hint:
		_update_bar_sprite()
		_update_fire_timer()


func decrease_fire_timer():
	fire_timer_percentage -= 1
	if fire_timer_percentage < FIRE_TIMER_OFF_PERCENTAGE:
		fire_timer_percentage = FIRE_TIMER_OFF_PERCENTAGE


func fire():
	cannon_ball_creator.create(position, direction * impulse)


func interact_start(interactor):
	if is_instance_valid(interactor):
		interact_detector = interactor
		_turn_off()
		bar_sprite.show()
		bar_sprite.play("Open")


func interact_end():
	interact_detector = null
	_turn_on()
	bar_sprite.play("Close")


func increase_fire_timer():
	fire_timer_percentage += 1
	if fire_timer_percentage > FIRE_TIMER_MAX_PERCENTAGE:
		fire_timer_percentage = FIRE_TIMER_MAX_PERCENTAGE


func _calculate_wait_time():
	var interval = fire_timer_max - fire_timer_min
	var percentage = 1 - ((fire_timer_percentage) / 10.0)
	return fire_timer_min + (interval * percentage)


func _invert(new_inverted):
	var collision_shape_node = get_node("Collision Shape")
	var sprite_node = get_node("Animated Sprite")
	
	if collision_shape_node and sprite_node:
		if !inverted:
			original_collision_shape_scale = collision_shape_node.scale
			original_sprite_flip_h = sprite_node.flip_h
		else:
			original_collision_shape_scale = collision_shape_node.scale * Vector2(-1, 1)
			original_sprite_flip_h = !sprite_node.flip_h
		
		if !new_inverted:
			collision_shape_node.scale = original_collision_shape_scale
			sprite_node.flip_h = original_sprite_flip_h
			direction = Vector2.LEFT
		else:
			collision_shape_node.scale = original_collision_shape_scale * Vector2(-1, 1)
			sprite_node.flip_h = !original_sprite_flip_h
			direction = Vector2.RIGHT
	
	inverted = new_inverted


func _turn_off():
	fire_timer_wait_time = 1
	on = false


func _turn_on():
	fire_timer_wait_time = _calculate_wait_time()
	if fire_timer_percentage != FIRE_TIMER_OFF_PERCENTAGE:
		on = true


func _update_bar_sprite():
	if bar_sprite.animation == "Charge":
		if fire_timer_percentage == FIRE_TIMER_MAX_PERCENTAGE:
			bar_sprite.play("Full")
		elif fire_timer_percentage == FIRE_TIMER_OFF_PERCENTAGE:
			bar_sprite.play("Empty")
		else:
			bar_sprite.frame = fire_timer_percentage
	
	if bar_sprite.animation == "Full":
			if fire_timer_percentage < FIRE_TIMER_MAX_PERCENTAGE:
				bar_sprite.play("Charge")
	
	if bar_sprite.animation == "Empty":
			if fire_timer_percentage > FIRE_TIMER_OFF_PERCENTAGE:
				bar_sprite.play("Charge")


func _update_fire_timer():
	if is_instance_valid(interact_detector):
		if DPadUtil.player_down(true):
			decrease_fire_timer()
		elif DPadUtil.player_up(true):
			increase_fire_timer()


func _on_bar_sprite_animation_finished():
	if bar_sprite.animation == "Open":
		bar_sprite.play("Charge")
		bar_sprite.stop()
	
	if bar_sprite.animation == "Close":
		bar_sprite.hide()
	
