extends Node
@onready var tile_map : TileMapLayer = %TileMapLayer
@onready var camera : Camera2D = %Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_pos = camera.get_global_mouse_position()
			var clicked_pos = tile_map.local_to_map(tile_map.to_local(global_pos))
			print(clicked_pos)
	
	if event is InputEventMouseMotion:
		var global_pos = camera.get_global_mouse_position()
		var hover_pos = tile_map.local_to_map(tile_map.to_local(global_pos))
		
		%HoverSprite.global_position = tile_map.map_to_local(hover_pos)
