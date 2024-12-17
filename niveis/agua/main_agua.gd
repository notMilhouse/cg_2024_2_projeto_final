extends Node3D

var mob_scene = preload("res://niveis/agua/mob_agua.tscn")
var amigo_scene = preload("res://niveis/agua/amigo_agua.tscn")
var player_scene = preload("res://niveis/agua/scenes/player_agua.tscn")
var player_scene_script = preload("res://niveis/agua/scenes/player_agua.gd")


var health = 5
var score = 0

func _ready():
	$UserInterface/RetryScreen.hide()
	$UserInterface/NextLevelScreen.hide()

func _on_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("SpawnPath/SpawnPosition")
	mob_spawn_location.progress_ratio = randf()
	mob.initialize(mob_spawn_location.position, $Player_agua)
	add_child(mob)

func _on_amigo_timer_timeout() -> void:
	var amigo = amigo_scene.instantiate()
	var amigo_spawn_location = get_node("SpawnPath/SpawnPosition")
	amigo_spawn_location.progress_ratio = randf()
	amigo.initialize(amigo_spawn_location.position, $Player_agua)
	add_child(amigo)


func _on_player_agua_hit() -> void:
	health -= 1
	if(health <= 0):
		$AmigoTimer.stop()
		$MobTimer.stop()
		$Player_agua.queue_free()
		$UserInterface/RetryScreen.show()
		
func _on_player_agua_catch() -> void:
	score += 1
	if(score >= 10):
		$AmigoTimer.stop()
		$MobTimer.stop()
		$Player_agua.queue_free()
		$UserInterface/NextLevelScreen.show()

		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_accept") and $UserInterface/RetryScreen.visible:
		get_tree().reload_current_scene()
	if event.is_action("ui_accept") and $UserInterface/NextLevelScreen.visible:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	if event.is_action_pressed("goToMenu"):
		# This restarts the current scene.
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_player_agua_moved() -> void:
	var camera_pivot = $CameraPivot.position
	var player_position = $Player_agua.position
	camera_pivot = Vector3(player_position.x, player_position.y, player_position.z)
	$CameraPivot.position = camera_pivot
