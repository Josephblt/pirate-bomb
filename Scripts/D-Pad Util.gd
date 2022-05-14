extends Node


func player_move_pressed():
	var horizontal = player_move_horizontal_pressed() 
	var down = player_move_down_pressed()
	return horizontal or down


func player_move_down_pressed():
	var down = Input.is_action_pressed("Player Down")
	var analog_down = Input.is_action_pressed("Player Down (Analog)")
	return down or analog_down


func player_move_horizontal_pressed():
	var left = player_move_left_pressed() 
	var right = player_move_right_pressed() 
	return left or right


func player_move_left_pressed():
	var left = Input.is_action_pressed("Player Left") 
	var analog_left = Input.is_action_pressed("Player Left (Analog)")
	return left or analog_left


func player_move_right_pressed():
	var right = Input.is_action_pressed("Player Right")
	var analog_right = Input.is_action_pressed("Player Right (Analog)")
	return right or analog_right
