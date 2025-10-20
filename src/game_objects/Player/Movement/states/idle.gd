extends PlayerMovementState


func physics_update(_delta: float) -> void:
	if input.get_direction():
		finished.emit(ACCEL)
