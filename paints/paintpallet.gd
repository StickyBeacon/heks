# PaintPalette.gd
extends GridContainer
class_name PaintPalette

@export_node_path("TileMapLayer") var tilemap_layer_path
@export var button_size := 48
@export var include_alternatives := true

signal tile_chosen(source_id: int, coords: Vector2i, alt_id: int)

@onready var _layer: TileMapLayer = %TileMapLayer
@onready var _tileset: TileSet = _layer.tile_set

func _ready() -> void:
	rebuild()

func rebuild() -> void:
	# clear old buttons
	for c in get_children():
		c.queue_free()
	
	var group := ButtonGroup.new()
	
	for source_id in _tileset.get_source_count():
		var src := _tileset.get_source(source_id)
		if src is TileSetAtlasSource:
			var atlas := src as TileSetAtlasSource
			var atlas_tex: Texture2D = atlas.get_texture()

			for coords in atlas.get_tiles_ids():
				var icon := _make_icon_from_atlas(atlas, atlas_tex, coords)
				_add_button(group, icon, source_id, coords, 0)

				if include_alternatives:
					for alt_id in atlas.get_alternative_tile_ids(coords):
						if alt_id == 0:
							continue
						# Alternatives usually share the same region; reuse icon.
						_add_button(group, icon, source_id, coords, alt_id)

func _make_icon_from_atlas(atlas: TileSetAtlasSource, atlas_tex: Texture2D, coords: Vector2i) -> Texture2D:
	var r: Rect2i = atlas.get_tile_texture_region(coords) # <-- key call
	var sub := AtlasTexture.new()
	sub.atlas = atlas_tex
	sub.region = Rect2(r.position, r.size) # AtlasTexture wants Rect2 (floats)
	sub.filter_clip = true
	return sub

func _add_button(group: ButtonGroup, icon: Texture2D, source_id: int, coords: Vector2i, alt_id: int) -> void:
	var btn := Button.new()
	btn.toggle_mode = true
	btn.button_group = group
	btn.icon = icon
	btn.expand_icon = true
	btn.custom_minimum_size = Vector2(button_size, button_size)
	btn.pressed.connect(func():
		emit_signal("tile_chosen", source_id, coords, alt_id)
	)
	add_child(btn)
