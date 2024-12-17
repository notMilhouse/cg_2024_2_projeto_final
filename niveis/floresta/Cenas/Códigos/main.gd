extends Node3D

var mob_scene = preload("res://niveis/floresta/Cenas/mob.tscn")
var amigo_scene = preload("res://niveis/floresta/Cenas/amigo.tscn")
var fruta_scene = preload("res://niveis/floresta/Cenas/fruta.tscn")

var quantidade_lobos = 10

signal main_kill
signal amigo_livre

@export var posicao = position
@onready var triste = $Triste
@onready var feliz = $Feliz
@onready var kill = $Kill
@onready var flecha = $Flecha


var i = 0

var health = 3
var score = 0
var vector = [0,1,0]

func _ready():
	quantidade_lobos = 10
	$Amigo.setRefPlayer($Player)
	$UserInterface/RetryScreen.hide()
	$UserInterface/NextLevelScreen.hide()
	
func _process(delta: float) -> void:
	if quantidade_lobos <= 0:
		amigo_livre.emit(delta)

func connect_to_mob_signals(mob: Mob):
	var stats: Stats = mob.get_node("Stats")
	stats.mob_kill.connect(_on_mob_stats_mob_kill_signal)

func _on_timer_timeout() -> void:
		var mob = mob_scene.instantiate()
		connect_to_mob_signals(mob)
		var mob_spawn_location = get_node("SpawnPath/SpawnPosition")
		mob_spawn_location.progress_ratio = randf()
		mob.initialize(mob_spawn_location.position, $Player)
		add_child(mob)

func _on_player_hit() -> void:
	health -= 1
	triste.play()
	if(health <= 0):
		$AmigoTimer.stop()
		$MobTimer.stop()
		$Player.set_visible(false)
		$UserInterface/RetryScreen.show()

func _on_player_catch() -> void:
	score += 1
	feliz.play()
	if(score >= 1):
		$AmigoTimer.stop()
		$MobTimer.stop()
		$UserInterface/NextLevelScreen.show()
		$Player.set_visible(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_accept") and $UserInterface/RetryScreen.visible:
		get_tree().reload_current_scene()
	if event.is_action("ui_accept") and $UserInterface/NextLevelScreen.visible:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	if event.is_action_pressed("goToMenu"):
			# This restarts the current scene.
			get_tree().change_scene_to_file("res://main_menu.tscn")

	
func _on_mob_stats_mob_kill_signal():
	kill.play()
	main_kill.emit()
	quantidade_lobos -= 1
	if quantidade_lobos < 1:
		_process(false)
		$MobTimer.stop()
		$AmigoTimer.stop()

func _on_amigo_timer_timeout() -> void:
	var fruta = fruta_scene.instantiate()
	var fruta_spawn_location = get_node("SpawnPath/SpawnPosition")
	fruta_spawn_location.progress_ratio = randf()
	fruta.initialize(fruta_spawn_location.position, $Player.position)
	add_child(fruta)

func _on_player_health() -> void:
	if health == 3:
		pass
	else:
		feliz.play()
		health += 1


func _on_player_arrow() -> void:
	flecha.play()
