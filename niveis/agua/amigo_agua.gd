extends CharacterBody3D

@export var min_speed = 5
@export var max_speed = 10

var timer = 0
var follow = true

func _process(delta):
	timer += delta
	if timer > 3:
		follow = false

func _physics_process(_delta):
	move_and_slide()
	if abs(position.x) + abs(position.z) > 100:
		die()

func position_amigo(source, target):
	look_at_from_position(source, target, Vector3.UP)

	var random_speed = randf_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed + Vector3.UP * random_speed * sin(rotation.x)
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	velocity = velocity.rotated(Vector3.FORWARD, rotation.x)

func initialize(start_position, player):
	position_amigo(start_position, player.position)

func die():
	queue_free()