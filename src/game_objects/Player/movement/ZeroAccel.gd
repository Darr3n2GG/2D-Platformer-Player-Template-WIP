class_name ZeroAccel extends AccelStrategy


func apply_acceleration(player: Player, direction: float, _delta: float) -> void:
	player.velocity.x = player.max_speed * direction
