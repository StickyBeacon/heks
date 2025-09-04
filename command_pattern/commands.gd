extends Node

class_name Command

func execute():
	push_error("execute() not implemented in %s" % self)

func undo():
	push_error("undo() not implemented")
