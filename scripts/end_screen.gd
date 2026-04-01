extends CanvasLayer

@onready var time_label = $CenterContainer/PanelContainer/VBoxContainer/MarginContainer/TimeResult
@onready var death_label = $CenterContainer/PanelContainer/VBoxContainer/MarginContainer2/DeathResult

func _ready() -> void:
	get_tree().paused = true
	
	var minutes = int(Global.time_elapsed / 60)
	var seconds = int(Global.time_elapsed) % 60
	time_label.text = "Time: %02d:%02d" % [minutes, seconds]
	death_label.text = "Deaths: " + str(Global.deaths)

func _on_restart_button_pressed() -> void:
	Global.reset_game_data()
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free() 

func _on_menu_button_pressed() -> void:
	Global.reset_game_data()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn" )
	queue_free()
