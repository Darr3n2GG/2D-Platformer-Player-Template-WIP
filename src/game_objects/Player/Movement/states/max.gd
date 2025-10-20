extends PlayerMovementState


func physics_update(_delta: float) -> void:
	if not input.get_direction():
		finished.emit(DECEL)
	elif is_turning():
		finished.emit(TURN)
