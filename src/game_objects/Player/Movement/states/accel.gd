extends PlayerMovementState



func physics_update(delta: float) -> void:
	var ticks := delta / 0.1
	var acceleration = player.max_speed * ticks
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * input.get_direction(), acceleration)
	
	if is_equal_approx(player.velocity.x, player.max_speed):
		finished.emit(MAX)
	elif not input.get_direction():
		finished.emit(DECEL)
	elif is_turning():
		finished.emit(TURN)
