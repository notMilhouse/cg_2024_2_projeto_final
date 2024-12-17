extends Area3D
# Lógica de vitoria (ao chegar perto do gamba) do jogo esta aqui 
# Lógica de passar de fase
@onready var player_name = "Player" 

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	$NextLevel.hide()
	
func _on_body_entered(body: Node3D) -> void:
	if body.name == player_name:
		$winfx.play()  
		await get_tree().create_timer($winfx.stream.get_length()).timeout  
		$NextLevel.show()
		#get_tree().quit()  
  
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $NextLevel.visible:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	if event.is_action_pressed("goToMenu"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
