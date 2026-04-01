extends Camera2D

@export var player: Node2D
@export var screen_size: Vector2 = Vector2(304, 160) 

func _physics_process(_delta: float) -> void:
	if not player:
		return
   
	var current_screen: int = floor(-(player.global_position.y - 80) / (screen_size.y))
	
	global_position = Vector2(0, -current_screen * screen_size.y)
