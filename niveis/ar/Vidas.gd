extends Label


var vidas = 3



func _on_player_damage():
	vidas -= 1 
	text = "Vidas atuais: %s" % vidas
