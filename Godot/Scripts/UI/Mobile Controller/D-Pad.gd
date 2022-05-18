extends TouchScreenButton

onready var stick = $"../Stick"

var move_vector = Vector2.ZERO
var active


func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if is_pressed():
			move_vector = _calculate_move_vector(event.position)
			print(move_vector)


func _process(_delta):
	stick.position = position + (normal.get_size() / 2)
	if active:
		stick.position += move_vector * shape.radius


func _calculate_move_vector(event_position):
	var center = position + (normal.get_size() / 2)
	var direction = event_position - center
	if direction.length() > shape.radius:
		direction = direction.normalized() * shape.radius
	return direction / shape.radius


func _on_pressed():
	active = true


func _on_released():
	active = false
