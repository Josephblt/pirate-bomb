extends Label


func _ready():
	text = "SIZE: " + str(get_viewport().get_visible_rect().size)
