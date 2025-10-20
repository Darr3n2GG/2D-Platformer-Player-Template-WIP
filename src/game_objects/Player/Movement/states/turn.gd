extends PlayerMovementState


func physics_update(delta: float) -> void:
	player.turn_strategy.apply_acceleration(player, input, delta)

	if not is_turning():
		finished.emit(ACCEL)
	elif is_equal_approx(player.velocity.x, player.max_speed * input.get_direction()) and input.get_direction():
		finished.emit(MAX)
	elif not input.get_direction():
		finished.emit(DECEL)
