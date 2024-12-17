extends Node

@export var StartingWeapon: PackedScene

var arco : Node3D
var mao 
signal health

func _ready():
	mao = get_parent().find_child("Hand")
	arco = StartingWeapon.instantiate()
	mao.add_child(arco)
	
func healthplus():
	health.emit()
