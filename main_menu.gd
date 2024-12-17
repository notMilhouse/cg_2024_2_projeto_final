extends Control



func _on_play_floresta_pressed() -> void:
	get_tree().change_scene_to_file("res://niveis/floresta/Cenas/main.tscn")

func _on_play_agua_pressed() -> void:
	get_tree().change_scene_to_file("res://niveis/agua/main_agua.tscn")

func _on_play_ar_pressed() -> void:
	get_tree().change_scene_to_file("res://niveis/ar/teste3.tscn")

func _on_play_marte_pressed() -> void:
	get_tree().change_scene_to_file("res://niveis/marte/scenes/Mars.tscn")

func _on_play_caverna_pressed() -> void:
	get_tree().change_scene_to_file("res://niveis/caverna/scenes/main.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("goToMenu"):
		# This restarts the current scene.
		get_tree().change_scene_to_file("res://main_menu.tscn")
