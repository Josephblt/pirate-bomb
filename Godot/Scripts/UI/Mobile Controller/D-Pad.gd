extends TextureButton

onready var stick = $"Analog Pad (Stick)"

var active
var move_vector = Vector2.ZERO
var radius
var size


func _ready():
	radius = rect_size.y / 2
	size = rect_size / 2


func _process(_delta):
	stick.rect_position = size  - (stick.rect_size / 2)
	if active:
		stick.rect_position += move_vector * radius
	else:
		DPadUtil.mobile_move = Vector2.ZERO


func _calculate_move_vector(event_position):
	var center = size
	var direction = event_position - center
	if direction.length() > radius:
		direction = direction.normalized() * radius
	return direction / radius


func _on_button_down():
	active = true


func _on_button_up():
	active = false


func _on_gui_input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		move_vector = _calculate_move_vector(event.position)
		if active:
			DPadUtil.mobile_move = move_vector
