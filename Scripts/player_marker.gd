extends Marker2D

func _physics_process(delta: float) -> void:
	self.look_at(get_global_mouse_position())
