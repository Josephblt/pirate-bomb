class_name TileMapVariation

extends TileMap

export var variation_amount = 25

var flip_h_map = {}
var position_map = {}
var variations = []


func _ready():
	randomize()
	set_flip_h_map()
	set_position_map()
	set_variations()
	_create()


func get_cell_id(_cell_coord):
	pass


func set_flip_h_map():
	pass


func set_position_map():
	pass


func set_variations():
	pass


func refresh():
	_clear()
	_create()



func _apply_variations(cell_coord):
	var cell_id = get_cell_id(cell_coord)
	var cell_world_position = map_to_world(cell_coord)
	
	if _is_variable_cell(cell_id):
		var positions = position_map[cell_id]
		for position in positions:
			if _should_create_variation():
				var world_position = cell_world_position + position
				var variation = _random_variation()
				var flip_h = _random_flip_h(cell_id)
				var flip_v = randi() % 2 == 1
				_create_variation(world_position, variation, flip_h, flip_v)


func _clear():
	for n in get_children():
		remove_child(n)
		n.queue_free()


func _create():
	var cell_coords = get_used_cells()
	for cell_coord in cell_coords:
		_apply_variations(cell_coord)


func _create_variation(world_position, variation, flip_h, flip_v):
	var sprite = Sprite.new()
	sprite.set_texture(variation)
	sprite.set_flip_h(flip_h)
	sprite.set_flip_v(flip_v)
	sprite.set_position(world_position)
	add_child(sprite)


func _is_variable_cell(cell_id):
	return position_map.has(cell_id);


func _random_variation(): 
	var variation_index = randi() % variations.size()
	return variations[variation_index]


func _random_flip_h(cell_id):
	if flip_h_map.has(cell_id):
		return flip_h_map[cell_id]
	else:
		return randi() % 2 == 1


func _should_create_variation():
	var variation_chance = 1 + randi() % 100
	return variation_chance <= variation_amount
