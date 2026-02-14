extends Node

var max_level_unlocked: int = 1  

func unlock_level(level_number: int) -> void:
	if level_number > max_level_unlocked:
		max_level_unlocked = level_number
