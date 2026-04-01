extends Area2D

@export var end_screen_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	var end_ui = end_screen_scene.instantiate()
	get_tree().root.add_child(end_ui)
