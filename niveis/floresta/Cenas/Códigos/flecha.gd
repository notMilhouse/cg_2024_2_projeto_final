extends Node3D
@export var velocidade = 70
var kill_time = 0.2
var timer = 0

func _physics_process(delta: float) -> void:
	var prafrente = global_transform.basis.z.normalized()
	global_translate(prafrente * velocidade * delta)
	timer += delta
	if timer >= kill_time:
		queue_free()

func _on_area_3d_body_entered(body: Node):
	if body.has_node("Stats"):
		var stats_node = body.find_child("Stats") as Stats
		stats_node.arrow_hit()
