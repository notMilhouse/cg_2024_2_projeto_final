extends CharacterBody3D


# How fast the player moves in meters per second.
@export var speed = 10
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16
var vidas = 3
var target_velocity = Vector3.ZERO
@onready var hit_sound = $HitSound
@onready var eagle_sound = $EagleSound



func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	if Input.is_action_pressed("move_down"):
		direction.y -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(-direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)

		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# If the collider is with a mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			# we check that we are hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				point.emit()
				target_velocity.y = bounce_impulse
				# Prevent further duplicate calls.
				break
		if collision.get_collider().is_in_group("aguia"):
			var mob = collision.get_collider()
			# we check that we are hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				kill_aguia.emit()
				position = Vector3(0,0,0)
				target_velocity.y = bounce_impulse
				# Prevent further duplicate calls.
				break
		
	# Moving the Character
	velocity = target_velocity
	move_and_slide()


signal hit
signal point
signal kill_aguia
signal damage

func die():
	hit.emit()
	queue_free()
	
func _on_area_3d_body_entered(body):
	if body.is_in_group("mob"):
 # Confirma se o objeto é o inimigo
		if hit_sound and not hit_sound.is_playing():  # Garante que o som não está tocando
			hit_sound.stop()	
			hit_sound.play()
		body.queue_free()
		if vidas > 0:
			vidas -=1
			damage.emit()	
		if vidas <=0:
			die()
	if body.is_in_group("aguia"):
		if eagle_sound and not eagle_sound.is_playing():  # Garante que o som não está tocando
			eagle_sound.stop()
			eagle_sound.play()
			print("Encontrou a águia!")
