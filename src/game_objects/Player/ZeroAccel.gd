class_name ZeroAccel extends AccelStrategy


func apply_acceleration(movement: PlayerMovement, direction: float, _delta: float) -> void:
	movement.velocity_x = movement.max_speed * direction
