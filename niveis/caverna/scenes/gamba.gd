extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var safe: Area3D = $Safe


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		print("Parabéns!")
		get_tree().quit()
