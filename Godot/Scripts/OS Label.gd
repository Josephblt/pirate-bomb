extends Label


func _process(_delta):
	text = "SIZE: " + str(get_viewport().get_visible_rect().size)
