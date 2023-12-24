extends Node


func player_attack(just_pressed = true):
	return _pressed("Player Attack", just_pressed)

func player_down(just_pressed = false):
	var down = _pressed("Player Down", just_pressed) 
	var analog_down = _pressed("Player Down (Analog)", just_pressed)
	return down or analog_down

func player_interact(just_pressed = false):
	return _pressed("Player Interact", just_pressed)

func player_jump(just_pressed = false):
	return _pressed("Player Jump", just_pressed)

func player_left(just_pressed = false):
	var left = _pressed("Player Left", just_pressed) 
	var analog_left = _pressed("Player Left (Analog)", just_pressed)
	return left or analog_left

func player_move(just_pressed = false):
	var left = player_left(just_pressed) 
	var right = player_right(just_pressed) 
	return left or right

func player_right(just_pressed = false):
	var right = _pressed("Player Right", just_pressed)
	var analog_right = _pressed("Player Right (Analog)", just_pressed)
	return right or analog_right

func player_walk(just_pressed = false):
	return _pressed("Player Walk", just_pressed)

func player_up(just_pressed = false):
	var up = _pressed("Player Up", just_pressed) 
	var analog_up = _pressed("Player Up (Analog)", just_pressed)
	return up or analog_up

func player_zoom_out(just_pressed = false):
	return _pressed("Player Zoom-out", just_pressed)


func _pressed(action, just_pressed = false):
	if just_pressed:
		return Input.is_action_just_pressed(action)
	else:
		return Input.is_action_pressed(action)
