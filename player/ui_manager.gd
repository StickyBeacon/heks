extends Node

func select_hex(pos : Vector2, unselect : bool = false):
	if unselect:
		%HexInfo.visible = false
		return
	%HexInfo.visible = true	
	%HexPos.text = "<%s,%s>" % [int(pos.x),int(pos.y)]


# code for the UI paint buttons
var selected_tile_id: int = -1

func _on_paint_button_pressed(tile_id: int):
	selected_tile_id = tile_id
	print("Selected tile:", tile_id)

@onready var tileset = %TileMapLayer.tile_set
#@onready var ui_buttons: HBoxContainer = $"../UI/CanvasLayer/UIButtons"
const PAINT_BUTTON = preload("res://paints/paint_button.tscn")

#func _ready():
	#create_paint_buttons(ui_buttons)
#
#func create_paint_buttons(container: Node):
	## Loop over all sources in the TileSet
	#for source_id in tileset.get_source_count():
		#var source = tileset.get_source(source_id)
		#if source is TileSetAtlasSource:
			#var atlas_source := source as TileSetAtlasSource
			#
			## Loop over all tile coords inside the atlas
			#for tile_id in atlas_source.get_tiles_count():
				#var coords = atlas_source.get_tile_id(tile_id) 
				#var texture = atlas_source.get_tile_texture(coords)
				#
				#if texture:
					#var btn = TextureButton.new()
					#btn.texture_normal = texture
					#btn.custom_minimum_size = Vector2(48, 48)
					#btn.connect("pressed", Callable(self, "_on_paint_button_pressed").bind(source_id, coords))
					#container.add_child(btn)
