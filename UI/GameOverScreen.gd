extends CanvasLayer

@onready var title = $PanelContainer/MarginContainer/Rows/Title

func _set_title(win: bool):
	if win:
		title.text = "YOU WIN!"
		title.modulate = Color.GREEN
	else:
		title.text = "YOU LOOSE!"
		title.modulate = Color.RED

func _on_restart_pressed():
	print("PULSO EL BOTÓN RESTART")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_exit_pressed():
	get_tree().quit()
