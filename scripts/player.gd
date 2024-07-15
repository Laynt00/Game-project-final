extends CharacterBody2D
class_name Player

signal died
signal player_health_changed(new_health)

@export var speed: int = 300

@onready var team = $Team
@onready var weapon = $Weapon
@onready var health_stat = $Health
@onready var camera_transform = $CameraTransform



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
		weapon.shoot()
	if event.is_action_pressed("reload"):
		weapon.start_reload()

# Permite dar un transform remoto
func set_camera_transform(camera_path: NodePath):
	camera_transform.remote_path = camera_path

func reload():
	weapon.start_reload()

func get_team() -> int:
	return team.team
	
func handle_hit():
	health_stat.health -= 10
	emit_signal("player_health_changed", health_stat.health)
	print(health_stat.health)
	if health_stat.health <= 0:
		die()
	
func die():
	emit_signal("died")
	queue_free()
