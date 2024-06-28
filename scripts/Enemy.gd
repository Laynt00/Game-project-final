extends CharacterBody2D
class_name Enemy

@onready var health_stat = $Health
@onready var ai = $AI
@onready var weapon = $Weapon


func _ready():
	ai.initialize(self, weapon)


func handle_hit():
	health_stat.health -= 20
	print("enemy hit!", health_stat.health)
	if health_stat.health <= 0:
		queue_free()
	
