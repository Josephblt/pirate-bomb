class_name FXCreator

extends Node

enum Effects {
	JUMP,
	LANDING,
	RUN
}

const fx_library  : Dictionary = {
	Effects.JUMP : preload("res://Game Objects/FX/Jump.tscn"),
	Effects.LANDING : preload("res://Game Objects/FX/Landing.tscn"),
	Effects.RUN : preload("res://Game Objects/FX/Run.tscn"),
}

onready var scene_root = $"/root"


func create(effect, position, flip = false):
	var fx_resource = fx_library[effect]
	var fx : FX = fx_resource.instance()
	fx.flip_h = flip
	fx.global_position = position
	scene_root.add_child(fx)
