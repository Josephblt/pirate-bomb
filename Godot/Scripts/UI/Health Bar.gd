extends Control

onready var heart1 = $"Bar/Heart 1"
onready var heart2 = $"Bar/Heart 2"
onready var heart3 = $"Bar/Heart 3"

var player


func _process(_delta):
	if player and is_instance_valid(player):
		_update_heart1(player.life >= 1)
		_update_heart2(player.life >= 2)
		_update_heart3(player.life == 3)
	else:
		player = get_node("/root/Player")


func _update_heart1(visible_flag):
	heart1.visible = visible_flag


func _update_heart2(visible_flag):
	heart2.visible = visible_flag


func _update_heart3(visible_flag):
	heart3.visible = visible_flag
