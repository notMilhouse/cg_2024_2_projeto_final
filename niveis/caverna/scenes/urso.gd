extends CharacterBody3D
# Lógica das perda de vida e fim do jogo esta aqui 
# Lógica de tentar novamente
@export var move_speed: float = 17.0  
@export var random_interval: float = 3.0  
@export var rotation_speed: float = 17.0  
@export var lives: int = 5  
@onready var vision: Area3D = $Vision
@onready var timer: Timer = $Timer  
@onready var player: Node3D  
@onready var lives_label: Label = $LivesLabel  

var target_velocity: Vector3 = Vector3.ZERO  

func _ready() -> void:
	vision.body_entered.connect(_on_vision_body_entered)
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = random_interval
	timer.start()
	change_direction()  
	update_lives_label()  
	$Retry.hide()

func _physics_process(delta: float) -> void:
	
	velocity = lerp(velocity, target_velocity, 0.1)  

	
	if target_velocity.length() > 0:
		var target_rotation_angle = atan2(target_velocity.x, target_velocity.z)  
		
		rotation_degrees.y = lerp_angle(rotation_degrees.y, rad_to_deg(target_rotation_angle), rotation_speed * delta)


	move_and_slide()

func _on_timer_timeout() -> void:
	change_direction()  

func change_direction() -> void:
	
	var random_direction = randi() % 2
	match random_direction:
		0: target_velocity = Vector3(0, velocity.y, move_speed)  # Frente
		1: target_velocity = Vector3(0, velocity.y, -move_speed)  # Trás

func _on_vision_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		lives -= 1
		$diefx.play()
		update_lives_label() 
		if lives <= 0:
			$diefx.play()
			await get_tree().create_timer($diefx.stream.get_length()).timeout
			$Retry.show() 
			#get_tree().quit()  

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $Retry.visible:
		get_tree().reload_current_scene()

func update_lives_label() -> void:
	lives_label.text = "Vidas: %d" % lives
