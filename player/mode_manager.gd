extends Node

var current_mode = 1
var current_paint_alt = 0
var amount_of_alts = 8
enum MODES {SELECT = 1, PAINT = 2}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		%ModeLabel.text = "MODE: SELECT" 
		current_mode = MODES.SELECT
	if event.is_action_pressed("2"):
		%ModeLabel.text = "MODE: PAINT" 
		if current_mode == MODES.PAINT:
			current_paint_alt = (current_paint_alt + 1) % amount_of_alts
			print("%s: changing paint to %s" % [name, current_paint_alt])
		else:
			current_mode = MODES.PAINT
