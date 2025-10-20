class_name ZeroAccel extends AccelStrategy


func apply_acceleration(player: CharacterBody2D, input: LRInput, _delta: float) -> void:
	player.velocity.x = player.max_speed * input.get_direction()
