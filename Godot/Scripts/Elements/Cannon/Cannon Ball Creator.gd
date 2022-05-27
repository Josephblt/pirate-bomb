extends Node

const CannonBall = preload("res://Game/Elements/Cannon/Cannon Ball.tscn")

onready var scene_root = $"/root"


func create(position, impulse = Vector2.ZERO):
	randomize()
	var random_torque = (randi() % 500) - 250
	
	var cannon_ball = CannonBall.instance()
	cannon_ball.position = position
	cannon_ball.add_torque(random_torque)
	cannon_ball.apply_central_impulse(impulse)
	scene_root.add_child(cannon_ball)
	return cannon_ball
