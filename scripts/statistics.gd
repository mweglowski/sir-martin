extends Label

func _process(_delta: float) -> void:
	var total_sec = int(Global.time_elapsed)
	var mins = total_sec / 60
	var secs = total_sec % 60
	text = "%02d:%02d 💀%d 🟡%d/5" % [mins, secs, Global.deaths, len(Global.collected_coin_ids)]
