extends Node

# TODO deze optie is nog niet geimplementeerd

"""

when true:
zolang de muis is gepressed 
commands worden geagregeerd onder 1 commando en dus in 1 ctrl-z ongedaan gemaakt 
en ctrl-y voor te herdoen

when false:
heeft ctrl-z invloed heeft op de kleinste eenheid 
van aanpassing

"""
var aggregate_pressing_commands := true

# TODO implement

"""

when true:
if you fire a new command while you can theoreticly still redo something that wass undone before.
you remove the capability to redo this

when false:
even when you edit after you undo you can still redo undone actions

"""
var hard_delete_redo := true
