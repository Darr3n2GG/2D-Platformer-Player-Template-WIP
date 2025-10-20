extends PlayerMovementState


func physics_update(delta: float) -> void:
	player.accel_strategy.apply_acceleration(player, input, delta)
	
	if is_equal_approx(player.velocity.x, player.max_speed * input.get_direction()) and input.get_direction():
		finished.emit(MAX)
	elif not input.get_direction():
		finished.emit(DECEL)
	elif is_turning():
		finished.emit(TURN)
