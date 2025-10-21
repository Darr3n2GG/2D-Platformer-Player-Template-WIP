class_name ConstAccel extends AccelStrategy


@export var accel_time: float = 0.1


func apply_acceleration(player: CharacterBody2D, input: LRInput, delta: float) -> void:	
	var ticks := accel_time / delta
	var acceleration = player.max_speed * (1 / ticks)
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * input.get_direction(), acceleration)
