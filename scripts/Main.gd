extends Node2D

@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player

func _ready():
	# Cuando conectas una signal lo haces desde el nodo que tiene la signal
	# después la funcion a la que llamamos como resultado de la conexión.
	# Usamos Callable para llamar a una función dentro de un objeto 
	GlobalSignals.bullet_fired.connect(Callable(bullet_manager, "handle_bullet_spawned"))

