# command_manager.gd
extends Node
class_name CommandManager

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_undo"):
		undo()
	elif Input.is_action_just_pressed("ui_redo"):
		redo()

var history: Array[Command] = []
var undone: Array[Command] = []

func do(command: Command):
	if command:
		command.execute()
		history.append(command)

# used when holding down to paint multiple tiles
# slight deviation from the pattern to allow more units of work
func do_without_save(command: Command):
	command.execute()

func save(command: Command):
	if command:
		history.append(command)
#

func undo():
	if history.is_empty():
		return
	var cmd = history.pop_back()
	if cmd:
		cmd.undo()
		undone.append(cmd)

func redo():
	if undone.is_empty():
		return
	var cmd = undone.pop_back()
	if cmd:
		cmd.execute()
		history.append(cmd)
