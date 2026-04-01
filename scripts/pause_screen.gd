extends CanvasLayer

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_controls_button_pressed() -> void:
	$ControlsScreen.show() 

func _on_restart_button_pressed() -> void:
	Global.reset_game_data()
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free() 

func _on_exit_button_pressed() -> void:
	Global.reset_game_data()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
