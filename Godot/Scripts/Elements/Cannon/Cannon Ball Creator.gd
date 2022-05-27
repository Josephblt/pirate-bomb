extends Node

const CannonBall = preload("res://Game/Elements/Cannon/Cannon Ball.tscn")

onready var scene_root = $"/root"


func create(position, impulse = Vector2.ZERO, torque = 100.0):
	var cannon_ball = CannonBall.instance()
	cannon_ball.position = position - Vector2(0, -5)
	cannon_ball.apply_central_impulse(impulse)
	cannon_ball.add_torque(torque)
	scene_root.add_child(cannon_ball)
	return cannon_ball
