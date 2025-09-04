extends Node

var max_x : int = 36
var min_x : int = -39
var max_y : int = 44
var min_y : int = -42

var text_dict : Dictionary[Vector2i, String] = {}
@onready var tile_map = %TileMapLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		save_map()
	if event.is_action_pressed("load"):
		load_map()


func save_map() -> void:
	var file = FileAccess.open("user://heks_data.txt", FileAccess.WRITE)
	var content = ""
	for j in range(min_y,max_y + 1):
		for i in range(min_x, max_x + 1):
			var line = "<%s,%s> " % [i,j]
			var color = %TileMapLayer.get_cell_alternative_tile(Vector2i(i,j))
			line += "(%s) " % color
			# Add stamp []
			
			if text_dict.has(Vector2i(i,j)):
				var text = text_dict[Vector2i(i,j)]
				text = text.replace(" ", "_")
				line += "{%s} " % text
			
			content += line + "\n" 
	file.store_string(content)
	print("%s: Saved!" % name)
	var dir = OS.get_data_dir()
	OS.alert("File saved at: %s as heks_data.txt" % dir)


func load_map() -> void:
	var file = FileAccess.open("user://heks_data.txt", FileAccess.READ)
	var content = file.get_as_text()
	var line_array = content.split("\n")
	
	for line in line_array:
		var things_array = line.split(" ")
		var pos : Vector2i = Vector2i(9999,9999)
		var variant = 0 
		var text = ""
		for thing : String in things_array:
			if thing.is_empty():
				continue
			match thing[0]:
				"<": # Position!
					var numbers = thing.substr(1, thing.length()-2).split(",")
					pos = Vector2i(int(numbers[0]), int(numbers[1]))
				"(":
					variant = int(thing.substr(1, thing.length()-2))
				"{":
					text = thing.substr(1, thing.length()-2)
					text = text.replace("_", " ")
				"[":
					pass
				_:
					print(things_array)
					printerr("%s: thing %s not recognized!" % [name, thing])
		
		if not text.is_empty():
			text_dict[pos] = text
		
		if pos != Vector2i(9999,9999):
			var current_atlas_coords = tile_map.get_cell_atlas_coords(pos)
			tile_map.set_cell(pos, tile_map.get_cell_source_id(pos), current_atlas_coords, variant)
	
	print("%s: Loaded!" % name)


func is_out_of_bounds(pos : Vector2) -> bool:
	if pos.x > max_x or pos.y > max_y or pos.x < min_x or pos.y < min_y:
		return true
	return false
