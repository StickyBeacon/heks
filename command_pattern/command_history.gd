# command_manager.gd
extends Node
class_name CommandManager

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_undo"):
		undo()
	elif Input.is_action_just_pressed("ui_redo"):
		redo()

var history: Array[Command] = []
var undone: Array[Command] = []  # holds undone commands

func do(command: Command):
	command.execute()
	history.append(command)

func undo():
	if history.is_empty():
		return
	var cmd = history.pop_back()
	cmd.undo()
	undone.append(cmd)

func redo():
	if undone.is_empty():
		return
	var cmd = undone.pop_back()
	cmd.execute()
	history.append(cmd)
