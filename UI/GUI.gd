extends CanvasLayer

@onready var health_bar = $MarginContainer/Rows/BottomRow/HealthSection/HealthBar
@onready var current_ammo = $MarginContainer/Rows/BottomRow/AmmoSection/CurrentAmmo
@onready var max_ammo = $MarginContainer/Rows/BottomRow/AmmoSection/TotalAmmo

var player: Player

func _set_player(player: Player):
	self.player = player
	
	_set_new_health_value(player.health_stat.health)
	_set_current_ammo(player.weapon.current_ammo)
	_set_max_ammo(player.weapon.max_ammo)
	
	player.player_health_changed.connect(Callable(self, "_set_new_health_value"))
	player.weapon.weapon_fired.connect(Callable(self, "_set_current_ammo"))
	
func _set_new_health_value(new_health : int):
	health_bar.value = new_health
	
func _set_current_ammo(new_ammo: int):
	current_ammo.text = str(new_ammo)
	
func _set_max_ammo(new_max_ammo: int):
	max_ammo.text = str(new_max_ammo)
