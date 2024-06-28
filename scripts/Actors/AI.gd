extends Node2D

signal state_changed(new_state)

#Enumeramos los estados que tendrá la IA
enum State{
	PATROL,
	ENGAGE
}


@onready var player_detection_zone = $PlayerDetectionZone



var current_state: int = State.PATROL : set = _set_state
var actor = null
var player: Player = null
var weapon: Weapon = null


func _process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				weapon.shoot()
			else:
				print("In the engage state but no weapon/player")
		_:
			print("Error: Found a state for our enemy that should not exist")


func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon

func _set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	state_changed.emit(current_state)
	


func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		_set_state(State.ENGAGE)
		player = body
