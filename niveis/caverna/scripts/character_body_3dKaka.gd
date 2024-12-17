extends CharacterBody3D

const SPEED = 5.0
var angular_speed = PI / 2
@onready var anim = $Kaka/AnimationPlayer



func _ready():
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction = -1
	if Input.is_action_pressed("move_left"):
		direction = 1
	rotation.y += angular_speed * direction * delta
	
	if Input.is_action_pressed("move_forward"):
		velocity = Vector3.MODEL_FRONT.rotated(Vector3.UP, rotation.y) * SPEED
	elif Input.is_action_pressed("move_back"):
		velocity = Vector3.MODEL_REAR.rotated(Vector3.UP, rotation.y) * SPEED 
	else:
		velocity = Vector3.ZERO
	
	if velocity.length() != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
			
	move_and_slide()
	
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("Você venceu!")
		get_tree().quit()
		get_tree().change_scene("res://scenes/WinScene.tscn")


func _on_safe_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
