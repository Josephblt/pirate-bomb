extends Camera2D

const MARGIN = 50

onready var _tile_map = $"../Foreground"


func _ready():
	_zoom_out()

func _process(_delta):
	if DPadUtil.player_zoom_out() and !current:
		make_current()


func _zoom_out():
	var window_size = get_viewport_rect().size
	window_size -= Vector2(MARGIN, MARGIN) * 2.0
	var tile_map_position = (_tile_map.get_used_rect().position * _tile_map.cell_size)
	var tile_map_size = _tile_map.get_used_rect().size * _tile_map.cell_size
	
	offset.x = (tile_map_size.x / 2.0) + tile_map_position.x
	offset.y = (tile_map_size.y / 2.0) + tile_map_position.y
	
	var scale_factor = tile_map_size / window_size
	scale_factor = max(scale_factor[0], scale_factor[1])
	zoom = Vector2(scale_factor, scale_factor)
