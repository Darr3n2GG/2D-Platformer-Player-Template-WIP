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
	if just_pressed() or just_released():
		var is_turning = sign(velocity_x) != sign(direction) and velocity_x != 0.0
		if direction == 0.0:
			final_time = decel_time
		elif is_turning:
			final_time = turn_time
		else:
			final_time = accel_time
		
func just_pressed() -> bool:
	return Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")

func just_released() -> bool:
	return Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right")
