extends Node2D

onready var animation = $"Animation Player"
onready var sprite = $"Animated Sprite"


func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	animation.play("Animate")
	sprite.play("Animate")


func _on_animation_finished():
	sprite.disconnect("animation_finished", self, "_on_animation_finished")
	queue_free()
