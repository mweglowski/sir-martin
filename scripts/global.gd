extends Node

var time_elapsed: float = 0.0
var total_coins : int = 0
var deaths : int = 0
var collected_coin_ids : Array = []
signal coins_changed(new_amount)

func add_coin(coin_id: String):
	if not collected_coin_ids.has(coin_id):
		total_coins += 1
		collected_coin_ids.append(coin_id)
		coins_changed.emit(total_coins)

func _process(delta: float) -> void:
	time_elapsed += delta

func reset_game_data():
	total_coins = 0
	deaths = 0
	time_elapsed = 0.0
	collected_coin_ids.clear()
