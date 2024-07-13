extends Area2D
class_name CapturableBase

signal base_captured(new_team)

@export var neutral_color = Color(1, 1, 1)
@export var player_color = Color(0.851, 0.536, 0.385)
@export var enemy_color = Color(0.251, 0.341, 0.746)


var player_unit_count : int = 0
var enemy_unit_count : int = 0
var team_to_capture: int = Team.TeamName.NEUTRAL

@onready var team = $Team
@onready var capture_timer = $CaptureTimer
@onready var sprite_2d = $Sprite2D


func _on_body_entered(body):
	# Si es un objeto con equipo
	if body.has_method("get_team"):
		var body_team = body.get_team()
		if body_team == Team.TeamName.ENEMY:
			enemy_unit_count += 1
		if body_team == Team.TeamName.PLAYER:
			player_unit_count += 1
	
	check_capture_flag()

func _on_body_exited(body):
	if body.has_method("get_team"):
		var body_team = body.get_team()
		if body_team == Team.TeamName.ENEMY:
			enemy_unit_count -= 1
		if body_team == Team.TeamName.PLAYER:
			player_unit_count -= 1
	
	check_capture_flag()
	
func check_capture_flag():
	var majority_team = get_team_with_mayority()
	if majority_team == Team.TeamName.NEUTRAL:
		print("Teams evened out, stopping capture clock")
		team_to_capture = Team.TeamName.NEUTRAL
		capture_timer.stop()
	elif majority_team == team.team:
		# Parar el countdown de captura si se inició
		print("Equipo con mayoría obtiene base, se para el countdown")
		team_to_capture = Team.TeamName.NEUTRAL
		capture_timer.stop()
	else:
		# Iniciar el countdown
		print("Nuevo equipo con mayoría, empiezo countdown")
		team_to_capture = majority_team
		capture_timer.start()
		
func get_team_with_mayority()-> int:
	if enemy_unit_count == player_unit_count:
		return Team.TeamName.NEUTRAL
	elif enemy_unit_count > player_unit_count:
		return Team.TeamName.ENEMY
	else:
		return Team.TeamName.PLAYER

func set_team(new_team: int):
	print("Entro en asignar color")
	team.team = new_team
	emit_signal("base_captured", new_team)
	match new_team:
		Team.TeamName.NEUTRAL:
			sprite_2d.modulate = neutral_color
			return
		Team.TeamName.PLAYER:
			sprite_2d.modulate = player_color
			return
		Team.TeamName.ENEMY:
			sprite_2d.modulate = enemy_color
			return


func _on_capture_timer_timeout():
	set_team(team_to_capture)
