extends Node3D

@export var flecha: PackedScene
@export var intervalo_de_tiro = true
@export var velocidade_de_tiro = 30
@onready var fire_rate = $Fire_Rate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shoot()
	
	
func shoot():
	if intervalo_de_tiro:
		if Input.is_action_pressed("jump"):
			var nova_flecha = flecha.instantiate()
			nova_flecha.global_transform = $Ponta.global_transform
			var raiz = get_tree().get_root().get_children()[0]
			raiz.add_child(nova_flecha)
			
			intervalo_de_tiro = false
			fire_rate.start()
	


func _on_fire_rate_timeout() -> void:
	intervalo_de_tiro = true
