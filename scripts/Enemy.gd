extends CharacterBody2D
class_name Enemy

@onready var health_stat = $Health
@onready var ai = $AI


func handle_hit():
	health_stat.health -= 20
	print("enemy hit!", health_stat.health)
	if health_stat.health <= 0:
		queue_free()
	
