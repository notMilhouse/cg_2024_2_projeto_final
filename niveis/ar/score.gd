extends Label

var score = 0


func _on_player_point():
	score += 1
	text = "Score: %s" % score
