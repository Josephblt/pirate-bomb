extends Label


func _ready():
	text = "TOUCHSCREEN: " + str(OS.has_touchscreen_ui_hint())
