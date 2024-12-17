extends Label
var health = 3

func _on_player_hit() -> void:
	health -= 1
	text = "Vida: %s" % health

func _on_player_health() -> void:
	if health == 3:
		pass
	else:
		health += 1
	text = "Vida: %s" % health
