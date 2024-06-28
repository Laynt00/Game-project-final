extends Node2D


@export var health: int = 100 : set = _set_state, get = _get_state
	
func _set_state(new_health):
	# Clamp se encarga de que los unicos valores posibles esten entre 0-100
	health = clamp(new_health, 0, 100)

func _get_state():
	return health
