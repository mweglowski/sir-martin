extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	if Global.collected_coin_ids.has(str(get_path())):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.add_coin(str(get_path()))
		animation_player.play('pickup')
