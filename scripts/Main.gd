extends Node2D

const Player = preload("res://Scenes/Player.tscn")

@onready var capturable_base_manager = $CapturableBaseManager
@onready var ally_ai = $AllyMapAI
@onready var enemy_ai = $EnemyMapAI
@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player
@onready var camera = $Camera2D
@onready var gui = $GUI
	

func _ready():
	# Esta función nos permite randomizar numeros cada vez que iniciamos
	randomize()
	# Cuando conectas una signal lo haces desde el nodo que tiene la signal
	# después la funcion a la que llamamos como resultado de la conexión.
	# Usamos Callable para llamar a una función dentro de un objeto 
	GlobalSignals.bullet_fired.connect(Callable(bullet_manager, "handle_bullet_spawned"))
	
	var ally_respawn = $AllyRespawnPoints
	var enemy_respawns = $EnemyRespawnPoints
	
	var bases = capturable_base_manager.get_capturable_bases()
	ally_ai.initialize(bases, ally_respawn.get_children())
	enemy_ai.initialize(bases, enemy_respawns.get_children())
	
	spawn_player()
	
func spawn_player():
	var player = Player.instantiate()
	add_child(player)			# con get_path cogemos el string del arbol de scenas
	player.set_camera_transform(camera.get_path())
	player.died.connect(Callable(self, "spawn_player"))
	gui._set_player(player)
	
	
