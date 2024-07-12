extends Node2D

@onready var capturable_base_manager = $CapturableBaseManager
@onready var ally_map_ai = $AllyMapAI
@onready var enemy_map_ai = $EnemyMapAI
@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player

func _ready():
	# Esta función nos permite randomizar numeros cada vez que iniciamos
	randomize()
	# Cuando conectas una signal lo haces desde el nodo que tiene la signal
	# después la funcion a la que llamamos como resultado de la conexión.
	# Usamos Callable para llamar a una función dentro de un objeto 
	GlobalSignals.bullet_fired.connect(Callable(bullet_manager, "handle_bullet_spawned"))
	
	var bases = capturable_base_manager.get_capturable_bases()
	ally_map_ai.initialize(bases)
	enemy_map_ai.initialize(bases)

