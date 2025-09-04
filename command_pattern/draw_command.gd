extends Command

class_name DrawCommand

var tile_map: TileMapLayer

var pos: Vector2
var speed: float = 200.0
var color: int

var old_color: int

func _init(_actor: TileMapLayer, _pos: Vector2, _color: int, _old_color: int):
	tile_map = _actor
	pos = _pos
	color = _color
	old_color = _old_color

func execute():
	if tile_map:
		var current_atlas_coords = tile_map.get_cell_atlas_coords(pos)
		tile_map.set_cell(pos, tile_map.get_cell_source_id(pos), current_atlas_coords, color)

func undo():
	if tile_map:
		var current_atlas_coords = tile_map.get_cell_atlas_coords(pos)
		tile_map.set_cell(pos, tile_map.get_cell_source_id(pos), current_atlas_coords, old_color)
