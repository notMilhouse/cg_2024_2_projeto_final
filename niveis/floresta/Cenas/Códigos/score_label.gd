extends Label
var lobos_restantes = 10

func _on_main_main_kill() -> void:
	lobos_restantes -= 1
	text = "Lobos Restantes: %s" % lobos_restantes 
