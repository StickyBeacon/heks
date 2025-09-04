extends Node

var is_writing : bool = false:
	set(value):
		%TextEditor.visible = value
		if value and not is_writing:
			%TextEditor.call_deferred("grab_focus")
		if not value:
			%TextEditor.release_focus()
			%TextEditor.text = ""
		is_writing = value

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		is_writing = false
	if event.is_action_pressed("enter"):
		if is_writing:
			var key = Vector2i(%TileSelect.selected_pos)
			var text = %TextEditor.text
			text = text.replace("\n", "")
			%TileDataManager.text_dict[key] = text
			%HexDescription.text = %TextEditor.text
		is_writing = not is_writing
