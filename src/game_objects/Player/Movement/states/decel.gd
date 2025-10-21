extends PlayerMovementState


func physics_update(delta: float) -> void:
	player.decel_strategy.apply_acceleration(player, input, delta)
	
	if is_zero_approx(player.velocity.x):
		finished.emit(IDLE)
	elif is_turning():
		finished.emit(TURN)
