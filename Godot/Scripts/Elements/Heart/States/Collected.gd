extends Node

onready var heart = $"../.."
onready var sprite = $"../../Animated Sprite"

var state_controller: StateController


func enter():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	sprite.play("Collected")


func _on_animation_finished():
	heart.destroy()
