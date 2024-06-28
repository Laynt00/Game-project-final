extends CharacterBody2D
class_name Player
# Cuando declaramos una signal estamos describiendo una acción ya realizada
signal player_fired_bullet(bullet, position, direction)

@export var speed: int = 300

@onready var weapon = $Weapon
@onready var health_stat = $Health

func _ready():
	weapon.connect("weapon_fired", shoot)
# Cada frame se llama a esta funcion
func _physics_process(delta):
	# con := le damos el tipo de dato directamente a la var
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1

	movement_direction = movement_direction.normalized()
	velocity = movement_direction * speed
	move_and_slide()

	look_at(get_global_mouse_position())


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		print("Click")
		weapon.shoot()
		
func shoot(bullet_instance, location: Vector2, direction: Vector2):
	print("Entra en funcion shoot")
	player_fired_bullet.emit(bullet_instance, location, direction)
	
func handle_hit():
	health_stat.health -= 20
	print("player hit!", health_stat.health)
