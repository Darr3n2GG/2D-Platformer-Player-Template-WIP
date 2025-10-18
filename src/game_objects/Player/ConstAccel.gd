class_name ConstAccel extends AccelStrategy

@export var accel_time: float = 0.1
@export var decel_time: float = 0.1
@export var turn_time: float = 0.2

var final_time: float


func apply_acceleration(movement: PlayerMovement, direction: float, delta: float) -> void:
	final_time = get_final_time(movement, direction)
	
	var ticks := delta / final_time
	movement.velocity_x = move_toward(movement.velocity_x, movement.max_speed * direction, movement.max_speed * ticks)
	
func get_final_time(movement: PlayerMovement, direction: float) -> float:	
	if movement.lr_input.just_pressed():
		var is_turning = movement.velocity_x != 0.0 and sign(movement.velocity_x) != direction
		if is_turning:
			return turn_time
		else:
			return accel_time
	
	elif movement.lr_input.just_released():
		return decel_time
	
	return final_time
