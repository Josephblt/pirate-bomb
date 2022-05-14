extends Sprite

export var allow_h_flip = true
export var allow_v_flip = true

func _ready():
	randomize()
	if allow_h_flip:
		flip_h = randi() % 2 == 0
	
	if allow_v_flip:
		flip_v = randi() % 2 == 0
