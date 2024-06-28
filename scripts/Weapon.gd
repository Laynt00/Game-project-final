extends Node2D
class_name  Weapon

@export var Bullet :PackedScene 

@onready var animation_player = $AnimationPlayer
@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var gunshot = $gunshot

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()
		var target = get_global_mouse_position()
		var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
		GlobalSignals.bullet_fired.emit(bullet_instance, end_of_gun.global_position, direction_to_mouse)
		gunshot.play()
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
