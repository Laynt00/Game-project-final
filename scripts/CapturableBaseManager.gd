extends Node2D

signal player_captured_all_bases
signal player_lost_all_bases

var capturable_bases: Array = []

# Conectamos la signal base_captured 
# y cada vez que una base sea capturada hacemos loop a las bases
# para ver si alguno de los dos equipos tiene todas las bases
func _ready():
	capturable_bases = get_children()
	for base in capturable_bases:
		base.base_captured.connect(Callable(self,"handle_base_captured"))

func get_capturable_bases() -> Array:
	return capturable_bases

# con _ le indicamos a godot que puede no tener el parámetro
func handle_base_captured(_team):
	var player_bases = 0
	var enemy_bases = 0
	var total_bases = capturable_bases.size()
	
	for base in capturable_bases:
		# team.team porque queremos la propiedad, no el nodo 
		match base.team.team:
			Team.TeamName.PLAYER:
				player_bases += 1
			Team.TeamName.ENEMY:
				enemy_bases += 1
			Team.TeamName.NEUTRAL:
				return
	if player_bases == total_bases:
		player_captured_all_bases.emit()
	elif enemy_bases == total_bases:
		player_lost_all_bases.emit()
