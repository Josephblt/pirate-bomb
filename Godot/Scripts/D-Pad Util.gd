extends Node


var mobile_move = Vector2.ZERO


func player_move_pressed():
	var horizontal = player_move_horizontal_pressed() 
	var down = player_move_down_pressed()
	return horizontal or down


func player_move_down_pressed():
	var down = Input.is_action_pressed("Player Down")
	var analog_down = Input.is_action_pressed("Player Down (Analog)")
	var mobile_down = mobile_move.y >= 0.25
	return down or analog_down or mobile_down


func player_move_horizontal_pressed():
	var left = player_move_left_pressed() 
	var right = player_move_right_pressed() 
	return left or right


func player_move_left_pressed():
	var left = Input.is_action_pressed("Player Left") 
	var analog_left = Input.is_action_pressed("Player Left (Analog)")
	var mobile_left = mobile_move.x <= -0.25
	return left or analog_left or mobile_left


func player_move_right_pressed():
	var right = Input.is_action_pressed("Player Right")
	var analog_right = Input.is_action_pressed("Player Right (Analog)")
	var mobile_right = mobile_move.x >= 0.25
	return right or analog_right or mobile_right
