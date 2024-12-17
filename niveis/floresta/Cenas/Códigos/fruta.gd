extends Node3D

func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)

func die():
	queue_free()
func _process(delta: float) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_node("Node"):
		var Player_node = body.find_child("Node")
		Player_node.healthplus()
		die()
