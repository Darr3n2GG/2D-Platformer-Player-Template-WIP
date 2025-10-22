class_name ConstAccel extends AccelStrategy

@export var accel_time: float = 0.1
@export var decel_time: float = 0.1
@export var turn_time: float = 0.2

var final_time: float


func apply_acceleration(player: Player, direction: float, delta: float) -> void:
	set_final_time(player.velocity.x, direction)
	var ticks := final_time / delta
	
	var acceleration = player.max_speed * (1 / ticks)
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * direction, acceleration)
	
func set_final_time(velocity_x: float, direction: float) -> void:	
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		var is_turning = velocity_x != 0.0 and sign(velocity_x) != sign(direction)
		if is_turning:
			final_time = turn_time
		else:
			final_time = accel_time
	
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		final_time = decel_time
