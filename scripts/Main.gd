extends Node2D

@onready var bullet_manager = $BulletManager
@onready var player = $Player

func _ready():
	pass
	# Cuando conectas una signal lo haces desde el nodo que tiene la signal
	# después la funcion a la que llamamos como resultado de la conexión.
	# Usamos Callable para llamar a una función dentro de un objeto 
	#player.connect("player_fired_bullet", Callable(bullet_manager, "handle_bullet_spawned"))
