extends CanvasLayer




func _on_play_pressed():
	print("PULSO EL BOTÓN RESTART")
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_exit_pressed():
	get_tree().quit()
