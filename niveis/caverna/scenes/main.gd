extends Node3D

func _ready() -> void:
	$bgfx.finished.connect(_on_bgfx_finished)  
	$bgfx.play()  

func _on_bgfx_finished() -> void:
	$bgfx.play()  

func _process(delta: float) -> void:
	pass
