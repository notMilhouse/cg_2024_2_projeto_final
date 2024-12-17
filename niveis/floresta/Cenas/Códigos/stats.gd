extends Node

class_name Stats

var hp = 1
signal mob_kill

func arrow_hit():
	mob_kill.emit()
	
