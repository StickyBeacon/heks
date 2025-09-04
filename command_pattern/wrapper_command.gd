extends Command

class_name WrapperCommand

var commands: Array[Command]

func _init():
	commands = []

func execute():
	for command in commands:
		command.execute()

func undo():
	for command in commands:
		command.undo()

func extend(command: Command):
	commands.push_back(command)
