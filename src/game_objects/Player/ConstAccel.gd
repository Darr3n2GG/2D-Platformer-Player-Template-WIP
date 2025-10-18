class_name ConstAccel extends AccelStrategy

@export var accel_time: float = 0.1
@export var decel_time: float = 0.1
@export var turn_time: float = 0.2


func apply_acceleration(movement: PlayerMovement, direction: float, delta: float) -> void:
	var final_time := get_final_time(movement, direction)
	
	var ticks := delta / final_time
	movement.velocity_x = move_toward(movement.velocity_x, movement.max_speed * direction, movement.max_speed * ticks)
	
func get_final_time(movement: PlayerMovement, direction: float) -> float:
	var final_time = decel_time
	
	if direction:
		final_time = accel_time
		
	return final_time
