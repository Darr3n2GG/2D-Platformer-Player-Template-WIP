class_name ConstAccel extends AccelStrategy


@export var accel_time: float = 0.1


func apply_acceleration(player: CharacterBody2D, input: LRInput, delta: float) -> void:	
	var ticks := delta / accel_time
	var acceleration = player.max_speed * ticks	
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * input.get_direction(), acceleration)
