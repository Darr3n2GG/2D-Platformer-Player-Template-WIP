class_name ConstAccel extends AccelStrategy

@export var accel_time: float = 0.1
@export var decel_time: float = 0.1
@export var turn_time: float = 0.2

var final_time: float


func apply_acceleration(movement, input: LRInput, delta: float) -> void:
	final_time = get_final_time(movement.velocity_x, input)
	
	var ticks := delta / final_time
	var acceleration = movement.max_speed * ticks
	movement.velocity_x = move_toward(movement.velocity_x, movement.max_speed * input.get_direction(), acceleration)
	
func get_final_time(velocity_x: float, input: LRInput) -> float:	
	if input.just_pressed():
		var is_turning = velocity_x != 0.0 and sign(velocity_x) != input.get_direction()
		if is_turning:
			return turn_time
		else:
			return accel_time
	
	elif input.just_released():
		return decel_time
	
	return final_time
