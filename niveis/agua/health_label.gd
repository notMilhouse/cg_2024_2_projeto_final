extends Label
var health = 5

func _on_player_agua_hit() -> void:
	health -= 1
	text = "Vida: %s" % health
