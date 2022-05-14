extends Node2D

onready var animation = $"Collision Shape/Animation Player"
onready var sprite = $"Animated Sprite"


func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	animation.play("Explode")
	sprite.play("Explode")


func _on_animation_finished():
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	queue_free()
