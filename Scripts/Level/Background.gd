extends TileMapVariation

const variation1 = preload("res://Sprites/Tilesets/Variations/Background 1.png")
const variation2 = preload("res://Sprites/Tilesets/Variations/Background 2.png")
const variation3 = preload("res://Sprites/Tilesets/Variations/Background 3.png")
const variation4 = preload("res://Sprites/Tilesets/Variations/Background 4.png")


func get_cell_id(cell_coord):
	var tile_coord = get_cell_autotile_coord(cell_coord.x, cell_coord.y)
	
	match tile_coord:
		Vector2(0,0):
			return 0
		Vector2(1,0):
			return 1
		Vector2(2,0):
			return 2
		Vector2(3,0):
			return 3
		Vector2(4,0):
			return 4
		Vector2(5,0):
			return 5
		Vector2(6,0):
			return 6
		Vector2(7,0):
			return 7
		Vector2(8,0):
			return 8
		Vector2(9,0):
			return 9
		Vector2(10,0):
			return 10
		Vector2(11,0):
			return 11
		
		Vector2(0,1):
			return 12
		Vector2(1,1):
			return 13
		Vector2(2,1):
			return 14
		Vector2(3,1):
			return 15
		Vector2(4,1):
			return 16
		Vector2(5,1):
			return 17
		Vector2(6,1):
			return 18
		Vector2(7,1):
			return 19
		Vector2(8,1):
			return 20
		Vector2(9,1):
			return 21
		Vector2(11, 1):
			return 22
		
		Vector2(0,2):
			return 23
		Vector2(1,2):
			return 24
		Vector2(2,2):
			return 25
		Vector2(3,2):
			return 26
		Vector2(4,2):
			return 27
		Vector2(5,2):
			return 28
		Vector2(6,2):
			return 29
		Vector2(7,2):
			return 30
		Vector2(8,2):
			return 31
		Vector2(9,2):
			return 32
		Vector2(10,2):
			return 33
		Vector2(11,2):
			return 34
			
		Vector2(0,3):
			return 35
		Vector2(1,3):
			return 36
		Vector2(2,3):
			return 37
		Vector2(3,3):
			return 38
		Vector2(4,3):
			return 39
		Vector2(5,3):
			return 40
		Vector2(6,3):
			return 41
		Vector2(7,3):
			return 42
		Vector2(8,3):
			return 43
		Vector2(9,3):
			return 44
		Vector2(10,3):
			return 45
		Vector2(11,3):
			return 46


func set_position_map():
	position_map = {
		0 : [],
		1 : [ Vector2(49, 16), Vector2(49, 48) ],
		2 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		3 : [ Vector2(15, 32) ],
		4 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		5 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		6 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		7 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		8 : [ Vector2(49, 16), Vector2(49, 48) ],
		9 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		10 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		11 : [ Vector2(15, 32) ],
		13: [ Vector2(49, 16), Vector2(49, 48) ],
		14 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		15 : [ Vector2(15, 32) ],
		16: [ Vector2(49, 16), Vector2(49, 48) ],
		17: [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		18 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		19 : [ Vector2(15, 32) ],
		20 : [ Vector2(49, 16), Vector2(49, 48) ],
		21 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		22 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		23 : [],
		24 : [ Vector2(49, 16), Vector2(49, 48) ],
		25 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		26 : [ Vector2(15, 32) ],
		27 : [ Vector2(49, 16), Vector2(49, 48) ],
		28 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		29 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		30 : [ Vector2(15, 0), Vector2(15, 32) ],
		31 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		32 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		33 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		34 : [ Vector2(15, 0), Vector2(15, 32) ],
		35 : [],
		36 : [ Vector2(49, 16), Vector2(49, 48) ],
		37 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		38 : [ Vector2(15, 32) ],
		39 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		40 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		41 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		42 : [ Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		43 : [ Vector2(49, 16), Vector2(49, 48) ],
		44 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		45 : [ Vector2(15, 0), Vector2(49, 16), Vector2(15, 32), Vector2(49, 48) ],
		46 : [ Vector2(15, 0), Vector2(15, 32) ],
	}


func set_variations():
	variations = [ 
		variation1,
		variation2,
		variation3,
		variation4,
	]
