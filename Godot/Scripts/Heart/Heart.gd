extends Node


const COLLECTIBLE_TYPE = Collect.COLLECTIBLE_TYPE.HEART


func destroy():
	queue_free()
