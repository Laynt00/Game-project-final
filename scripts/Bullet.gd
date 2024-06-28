extends Area2D

@export var speed: int = 6

var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed

		global_position += velocity

func set_direction(direction : Vector2):
	# Usamos self. para indicar que es el valor del parametro y no de la var fuera de la funcion
	#self.direction = direction
	self.direction = direction
