extends CharacterBody3D

class_name Mob
var main_scene = preload("res://niveis/floresta/Cenas/main.tscn")
@export var max_speed = 10
var direction
var player

func _physics_process(_delta):
	
	look_at(Vector3(player.position.x,0,player.position.z))
	velocity = Vector3.FORWARD * max_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	move_and_slide()

func initialize(start_position, refPlayer):
	player = refPlayer
	look_at_from_position(start_position, player.position, Vector3.UP)

func _on_visible_on_screen_notifier_screen_exited():
	queue_free()

func die():
	queue_free()

func _on_stats_mob_kill():
	queue_free()
