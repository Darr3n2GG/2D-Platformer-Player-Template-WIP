class_name ZeroAccel extends AccelStrategy


func apply_acceleration(movement, input: LRInput, _delta: float) -> void:
	movement.velocity_x = movement.max_speed * input.get_direction()
