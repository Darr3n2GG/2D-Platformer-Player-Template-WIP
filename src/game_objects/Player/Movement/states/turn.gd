extends PlayerMovementState


func physics_update(delta: float) -> void:
	var ticks := delta / 0.1
	var acceleration = player.max_speed * ticks
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * input.get_direction(), acceleration)
	
	if not is_turning():
		finished.emit(ACCEL)
	elif not input.get_direction():
		finished.emit(DECEL)
