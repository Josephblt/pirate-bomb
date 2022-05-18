extends Label


func _ready():
	text = "Mobile: " + str(OS.has_feature("mobile"))
