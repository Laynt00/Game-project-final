extends Area2D

#@export var neutral_color = Color(1, 1, 1)
#@export var player_color = Color(0.851, 0.536, 0.385)
#@export var enemy_color = Color(0.251, 0.341, 0.746)
#
#
#var player_unit_count : int = 0
#var enemy_unit_count : int = 0
#
#
##func _on_body_entered(body):
	##if body.has_method("get_team"):
		##var body_team = body.get_team()
		##if body_team = Team.TeamName.ENEMY:
			##enemy_unit_count += 1
		##if body_team = Team.TeamName.PLAYER:
			##player_unit_count += 1
#
##func _on_body_exited(body):
	##if body.has_method("get_team"):
