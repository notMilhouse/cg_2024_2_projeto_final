extends CharacterBody3D

signal hit
signal catch
signal arrow
signal health

var movement
var state_machine
var tiro

@onready var anim_tree = $Pivot/Esqueleto/AnimationTree
@onready var anim_player = $Pivot/Esqueleto/AnimationPlayer
@export var speed = 20

var target_velocity = Vector3.ZERO

func _ready():
	state_machine = anim_tree.get("parameters/playback")

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	match state_machine.get_current_node():
		"run":
				if Input.is_action_pressed("move_right"):
					direction.x += 1
				if Input.is_action_pressed("move_left"):
					direction.x -= 1
				if Input.is_action_pressed("move_back"):
					direction.z += 1
				if Input.is_action_pressed("move_forward"):
					direction.z -= 1
		"tiro":
			pass
		"idle":
			if Input.is_action_pressed("move_right"):
					direction.x += 1
			if Input.is_action_pressed("move_left"):
				direction.x -= 1
			if Input.is_action_pressed("move_back"):
				direction.z += 1
			if Input.is_action_pressed("move_forward"):
				direction.z -= 1

	anim_tree.set("parameters/conditions/run", _movement())
	anim_tree.set("parameters/conditions/tiro", _shotting())
	anim_tree.set("parameters/conditions/notrun", _nomovement())
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(-direction)
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	velocity = target_velocity
	move_and_slide()

	if is_on_floor() and Input.is_action_pressed("jump"):
		arrow.emit()
		
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			mob.die()
			hit.emit()
			break
		if collision.get_collider().is_in_group("amigo"):
			var amigo = collision.get_collider()
			amigo.die()
			catch.emit()
			break
		

func _movement():
	if Input.is_action_pressed("move_right"):
		return true
	if Input.is_action_pressed("move_left"):
		return true
	if Input.is_action_pressed("move_back"):
		return true
	if Input.is_action_pressed("move_forward"):
		return true
		
func _shotting():
	if is_on_floor() and Input.is_action_pressed("jump"):
		return true
	else:
		return false
func _nomovement():
	if Input.is_anything_pressed() == false:
		return true

func _on_node_health() -> void:
	health.emit()
