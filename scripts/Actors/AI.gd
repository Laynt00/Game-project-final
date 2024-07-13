extends Node2D
class_name AI

signal state_changed(new_state)

#Enumeramos los estados que tendrá la IA
enum State{
	PATROL,
	ENGAGE,
	ADVANCE
}

@onready var patrol_timer = $PatrolTimer



var current_state: int = -1 : set = _set_state
var actor: Actor = null
var target: CharacterBody2D = null
var weapon: Weapon = null
var team: int = -1

# PATROL STATE
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO

# ADVANCE STATE
var next_base: Vector2 = Vector2.ZERO

func _ready():
	_set_state(State.PATROL)
	
		#GlobalSignals.bullet_fired.connect(Callable(bullet_manager, "handle_bullet_spawned"))
	
func _physics_process(delta):
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				#actor.move_and_slide(actor_velocity)
				actor_velocity = actor.velocity_toward(patrol_location)
				actor.velocity = actor_velocity
				actor.move_and_slide()
				actor.rotate_toward(patrol_location)
				# Si el actor ha llegado a la localizacion 
				if actor.has_reached_pos(patrol_location):
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					#actor_velocity - Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if target != null and weapon != null:
				# Rotamos hasta enfrentar al enemigo
				actor.rotate_toward(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				var enemy_shoot_angle = abs(rad_to_deg(angle_to_target) - fmod(actor.rotation_degrees, 360))
				if enemy_shoot_angle < 30 or enemy_shoot_angle > 330 :
					weapon.shoot()
			else:
				print("In the engage state but no weapon/target")
		State.ADVANCE:
			if actor.has_reached_pos(next_base):
				_set_state(State.PATROL)
			else:
				actor_velocity = actor.velocity_toward(next_base)
				actor.velocity = actor_velocity
				actor.move_and_slide()
				actor.rotate_toward(next_base)
		_:
			print("Error: Found a state for our enemy that should not exist")


func initialize(actor: CharacterBody2D, weapon: Weapon, team: int):
	self.actor = actor
	self.weapon = weapon
	self.team = team
	#objeto.signal.connect(Callable(objeto, funcion) #FUNCIONAAA!!!!!  ESTÁAAA VIVOOOOO
	weapon.weapon_out_of_ammo.connect(Callable(self, "handle_reload"))

func _set_state(new_state: int):
	if new_state == current_state:
		return
	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true
	elif new_state == State.ADVANCE:
		if actor.has_reached_pos(next_base):
			_set_state(State.PATROL)
		
	current_state = new_state
	state_changed.emit(current_state)
	
func handle_reload():
	print("Entro en handle_reload")
	weapon.start_reload()

func _on_patrol_timer_timeout():
	var patrol_range = 50
	var random_x = randf_range(-patrol_range, patrol_range) 
	var random_y = randf_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + origin
	patrol_location_reached = false
	


func _on_detection_zone_body_entered(body):
	print("Entro en la zona")
	if body.has_method("get_team") and body.get_team() != team:
		_set_state(State.ENGAGE)
		target = body

func _on_detection_zone_body_exited(body):
	print("Salgo de zona")
	if target and body == target:
		_set_state(State.ADVANCE)
		target == null
