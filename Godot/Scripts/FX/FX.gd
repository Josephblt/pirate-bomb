class_name FX

extends AnimatedSprite


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")


func _on_animation_finished():
	disconnect("animation_finished", self, "_on_animation_finished")
	queue_free()
