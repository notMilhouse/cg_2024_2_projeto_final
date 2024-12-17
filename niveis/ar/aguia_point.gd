extends Label

var aguia_score = 3



func _on_player_kill_aguia():
	aguia_score -= 1
	text = "Faltam %s águias" % aguia_score
