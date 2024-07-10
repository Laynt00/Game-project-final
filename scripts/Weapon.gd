extends Node2D
class_name  Weapon

signal weapon_out_of_ammo

@export var Bullet :PackedScene 

@onready var animation_player = $AnimationPlayer
@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var gunshot = $gunshot
@onready var muzzle_flash = $MuzzleFlash

var max_ammo: = 10
var current_ammo: int = max_ammo

func _ready():
	muzzle_flash.hide()

func start_reload():
	print("recargo")
	animation_player.play("reload")


func stop_reload():
	current_ammo = max_ammo


func shoot():
	if current_ammo != 0 and attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()
		#var target = get_global_mouse_position()
		#var direction = end_of_gun.global_position.direction_to(target).normalized()
		var direction = (end_of_gun.global_position - global_position).normalized()
		GlobalSignals.bullet_fired.emit(bullet_instance, end_of_gun.global_position, direction)
		gunshot.play()
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
		current_ammo -= 1
		if current_ammo == 0:
			weapon_out_of_ammo.emit()
