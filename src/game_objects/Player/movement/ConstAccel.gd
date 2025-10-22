class_name ConstAccel extends AccelStrategy

@export var accel_time: float = 0.1
@export var decel_time: float = 0.1
@export var turn_time: float = 0.2

var final_time: float


func apply_acceleration(movement: PlayerMovement, input: LRInput, delta: float) -> void:
	set_final_time(movement.velocity_x, input)
	var ticks := final_time / delta
	
	var acceleration = movement.max_speed * (1 / ticks)
	movement.velocity_x = move_toward(movement.velocity_x, movement.max_speed * input.get_direction(), acceleration)
	
func set_final_time(velocity_x: float, input: LRInput) -> void:	
	if input.just_pressed():
		var is_turning = velocity_x != 0.0 and sign(velocity_x) != sign(input.get_direction())
		if is_turning:
			final_time = turn_time
		else:
			final_time = accel_time
	
	elif input.just_released():
		final_time = decel_time
