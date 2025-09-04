extends Node

@onready var tile_map : TileMapLayer = %TileMapLayer
@onready var camera : Camera2D = %Camera2D

var selected_pos : Vector2 = Vector2.ZERO
var selected : bool = false:
	set(value):
		selected = value
		%SelectSprite.visible = value


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_pos = camera.get_global_mouse_position()
			var clicked_pos = tile_map.local_to_map(tile_map.to_local(global_pos))
			make_action(clicked_pos)
	
	if event is InputEventMouseMotion:
		var global_pos = camera.get_global_mouse_position()
		var hover_pos = tile_map.local_to_map(tile_map.to_local(global_pos))
		if %TileDataManager.is_out_of_bounds(hover_pos):
			%HoverSprite.visible = false
		else:
			%HoverSprite.visible = true
			%HoverSprite.global_position = tile_map.map_to_local(hover_pos)
			
			if %ModeManager.current_mode == 2:
				if Input.is_action_pressed("left_click"):
					paint(hover_pos)
		

func select_hex(pos : Vector2) -> void:
	if (pos == selected_pos and selected) or %TileDataManager.is_out_of_bounds(pos):
		selected = false
		%UIManager.select_hex(pos, true)
		return
	
	selected = true
	%SelectSprite.global_position = tile_map.map_to_local(pos)
	%UIManager.select_hex(pos)
	selected_pos = pos
	
	var key = Vector2i(int(pos.x), int(pos.y))
	
	if %TileDataManager.text_dict.has(key):
		%HexDescription.text = %TileDataManager.text_dict[key]
		if %TileDataManager.text_dict[key] == "":
			%HexDescription.text = "[no description]"
	else:
		%HexDescription.text = "[no description]"

func make_action(pos : Vector2):
	match %ModeManager.current_mode:
		1:
			select_hex(pos)
		2:
			paint(pos)
		_:
			print("%s: mode %s doesnt exist " % [name, %ModeManager.current_mode])


func paint(pos : Vector2):
	var current_atlas_coords = tile_map.get_cell_atlas_coords(pos)
	tile_map.set_cell(pos, tile_map.get_cell_source_id(pos), current_atlas_coords, %ModeManager.current_paint_alt)
