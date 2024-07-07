extends Node2D

signal state_changed(new_state)

#Enumeramos los estados que tendrá la IA
enum State{
	PATROL,
	ENGAGE
}


@onready var player_detection_zone = $PlayerDetectionZone
@onready var patrol_timer = $PatrolTimer



var current_state: int = -1 : set = _set_state
var actor: CharacterBody2D = null
var target: CharacterBody2D = null
var weapon: Weapon = null
var team: int = -1

# PATROL STATE
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO

func _ready():
	_set_state(State.PATROL)
func _physics_process(delta):
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				#actor.move_and_slide(actor_velocity)
				actor.velocity = actor_velocity
				actor.move_and_slide()
				actor.rotate_toward(patrol_location)
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached = true
					actor_velocity - Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:			
			if target != null and weapon != null:
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				actor.rotate_toward(target.global_position)
				print(abs(actor.rotation - angle_to_target))
				# Para que  empiece a disparar solo cuando esta cerca de apuntarle
				#if abs(actor.rotation - angle_to_target) < 0.4:
				weapon.shoot()
			else:
				print("In the engage state but no weapon/target")
		_:
			print("Error: Found a state for our enemy that should not exist")


func initialize(actor: CharacterBody2D, weapon: Weapon, team: int):
	self.actor = actor
	self.weapon = weapon
	self.team = team

func _set_state(new_state: int):
	if new_state == current_state:
		return
	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true
		
	current_state = new_state
	state_changed.emit(current_state)
	

func _on_patrol_timer_timeout():
	var patrol_range = 50
	var random_x = randf_range(-patrol_range, patrol_range) 
	var random_y = randf_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + origin
	patrol_location_reached = false
	actor_velocity = actor.velocity_toward(patrol_location)


func _on_detection_zone_body_entered(body):
	if body.has_method("get_team") and body.get_team() != team:
		print("Entro en zona")
		if body.is_in_group("player"):
			_set_state(State.ENGAGE)
			target = body

func _on_detection_zone_body_exited(body):
	print("Salgo de zona")
	if target and body == target:
		_set_state(State.PATROL)
		target == null
