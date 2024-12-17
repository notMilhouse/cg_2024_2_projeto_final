extends CharacterBody3D

const SPEED = 15.0
var direction
var randommov = Vector3(randf_range(-30,30),15, randf_range(-17,17))
var player

func setRefPlayer(refPlayer):
	player = refPlayer

func _physics_process(delta: float):
	var ponto = randommov
	direction = (ponto - position).normalized()
	var lugar = abs(ponto - position)
	var valor = lugar.length()
	velocity = velocity.lerp(direction * SPEED, delta *10)
	if valor <= 0.8:
		randommov = Vector3(randf_range(-30,30),15, randf_range(-17,17))
	look_at(ponto)
	move_and_slide()
		
func die():
	queue_free()

func _on_main_amigo_livre(delta: float) -> void:
	var ponto = Vector3(position.x, 1, position.z)
	direction = (ponto - position).normalized()
	var lugar = abs(ponto - position)
	var valor = lugar.length()
	velocity = velocity.lerp(direction * SPEED, delta *10)
	if valor <= 0.9:
		velocity = Vector3(0,0,0)
		look_at(player.position)
	move_and_slide()
