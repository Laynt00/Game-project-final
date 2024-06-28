extends Node2D

func handle_bullet_spawned(bullet):
	print("Se ha emitido")
	add_child(bullet)
	#bullet.global_position = position
	#bullet.set_direction(direction)
