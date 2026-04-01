extends StaticBody2D

@export var coins_required: int = 5

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready() -> void:
	Global.coins_changed.connect(_on_coins_changed)
	_check_wall_status(Global.total_coins)

func _on_coins_changed(new_total: int) -> void:
	_check_wall_status(new_total)

func _check_wall_status(current_total: int) -> void:
	if current_total >= coins_required:
		open_wall()

func open_wall() -> void:
	if Global.coins_changed.is_connected(_on_coins_changed):
		Global.coins_changed.disconnect(_on_coins_changed)
	
	collision.set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0) # Fade animation
	tween.tween_callback(queue_free)
