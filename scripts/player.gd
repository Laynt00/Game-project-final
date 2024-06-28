extends CharacterBody2D
# Cuando declaramos una signal estamos describiendo una acción ya realizada
signal player_fired_bullet(bullet, position, direction)

@export var Bullet :PackedScene 
@export var speed: int = 300

@onready var end_of_gun = $EndOfGun

func _ready():
	pass
# Cada frame se llama a esta funcion
func _process(delta):
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
		shoot()
		
func shoot():
	var bullet_instance = Bullet.instantiate()
	# El transform aplicado al padre Player también se aplica a los nodos hijos
	# por eso en esta situación al rotal el player también lo harán las balas
	#add_child(bullet_instance) 
	bullet_instance.global_position = end_of_gun.global_position
	var target = get_global_mouse_position()
	#var direction_to_mouse = target - bullet_instance.global_position
	var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
	emit_signal("player_fired_bullet", bullet_instance, end_of_gun.global_position, direction_to_mouse)
