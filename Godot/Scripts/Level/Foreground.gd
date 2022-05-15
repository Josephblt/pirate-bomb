extends TileMapVariation

const variation1 = preload("res://Sprites/Tilesets/Variations/Foreground 1.png")
const variation2 = preload("res://Sprites/Tilesets/Variations/Foreground 2.png")
const variation3 = preload("res://Sprites/Tilesets/Variations/Foreground 3.png")
const variation4 = preload("res://Sprites/Tilesets/Variations/Foreground 4.png")


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.FOREGROUND)


func get_cell_id(cell_coord):
	var tile_coord = get_cell_autotile_coord(cell_coord.x, cell_coord.y)

	match tile_coord:
		Vector2(0,0):
			return 0
		Vector2(1,0):
			return 1
		Vector2(2,0):
			return 2
		Vector2(0,1):
			return 3
		Vector2(1,1):
			return 4
		Vector2(2,1):
			return 5
		Vector2(0,2):
			return 6
		Vector2(1,2):
			return 7
		Vector2(2,2):
			return 8
		Vector2(0,3):
			return 9
		Vector2(1,3):
			return 10
		Vector2(0,4):
			return 11
		Vector2(1,4):
			return 12


func set_flip_h_map():
	flip_h_map = {
		3 : false,
		5 : true,
		9 : true,
		10 : false,
		11 : true,
		12 : false,
	}


func set_position_map():
	position_map = {
		0 : [ Vector2(51, 19), Vector2(51, 51) ],
		1 : [ Vector2(51, 19), Vector2(17, 35), Vector2(51, 51) ],
		2 : [ Vector2(17, 35) ],
		3 : [ Vector2(51, 19), Vector2(51, 51) ],
		5 : [ Vector2(17, 3), Vector2(17, 35) ],
		6 : [ Vector2(51, 19) ],
		7 : [ Vector2(51, 19), Vector2(17, 35) ],
		8 : [ Vector2(17, 35), ],
		9 : [ Vector2(17, 35) ],
		10 : [ Vector2(51, 19), Vector2(51, 51) ],
		11 : [ Vector2(17, 3), Vector2(17, 35) ],
		12 : [ Vector2(51, 19), Vector2(51, 51) ],
	}


func set_variations():
	variations = [
		variation1,
		variation2,
		variation3,
		variation4,
	]
