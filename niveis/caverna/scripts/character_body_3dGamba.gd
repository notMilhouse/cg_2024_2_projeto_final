extends CharacterBody3D

const SPEED = 5.0
var angular_speed = PI / 2
@onready var anim = $trabalhoWithAnim/AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction = -1
	if Input.is_action_pressed("ui_left"):
		direction = 1
	rotation.y += angular_speed * direction * delta
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector3.LEFT.rotated(Vector3.UP, rotation.y) * SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector3.RIGHT.rotated(Vector3.UP, rotation.y) * SPEED 
	else:
		velocity = Vector3.ZERO
	
	if velocity.length() != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
		
	move_and_slide()
