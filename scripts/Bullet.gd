extends Area2D
class_name Bullet

@export var speed: int = 4
@onready var kill_timer = $KillTimer

var direction := Vector2.ZERO

func _ready():
	# Tiempo en juego de la bala
	kill_timer.start()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
#
func set_direction(direction : Vector2):
	# Usamos self. para indicar que es el valor del parametro y no de la var fuera de la funcion
	#self.direction = direction
	self.direction = direction


func _on_kill_timer_timeout():
	queue_free()

# Toca a un cuerpo con método "Handle_hit"
func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
	queue_free()
