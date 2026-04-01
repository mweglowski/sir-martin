extends CanvasLayer

# Drag your actual game scene file here in the Inspector
@export var game_scene_path: String = "res://scenes/game.tscn"

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene_path)

func _on_controls_button_pressed() -> void:
	$ControlsScreen.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
