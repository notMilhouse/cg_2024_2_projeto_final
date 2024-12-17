extends PathFollow3D


# Called when the node enters the scene tree for the first time.
var bird_speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress(get_progress() + delta*bird_speed) 
