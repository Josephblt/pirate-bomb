extends TileMap


func _ready():
	LayersUtil.activate_layer(self, LayersUtil.PLATFORMS)
