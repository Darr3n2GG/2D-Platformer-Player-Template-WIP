# NEEDS REFACTORING

class_name LinearAccel extends AccelStrategy

enum LinearTypes {INCREASING, DECREASING}

@export var accel_type := LinearTypes.DECREASING
@export var accel_time: float

var accel_dict := {
	"final_speed": 0.0,
	"ticks": 0.0,
	"accel_factor": 0.0,
	"initial_accel": 0.0,
	"offset": 0.0
}
var on_wall_last_frame: bool
var on_ceiling_last_frame: bool


func apply_acceleration(player: CharacterBody2D, input: LRInput, delta: float) -> void:
	var acceleration: float
	
	accel_dict.ticks = accel_time / delta
	
	# if time taken to reach final speed is too low
	if accel_dict.ticks <= 0.0:
		acceleration = player.max_speed
	else:
		if is_input_active(player, input):
			init_accel_dict(player, input)
		
		var reached_final_velocity := is_equal_approx(player.velocity.x, player.max_speed * input.get_direction())
		if not reached_final_velocity:
			acceleration = get_acceleration(player, delta)
			
			# If acceleration is negative, reset
			if acceleration < 0:
				acceleration = 0.0
		
		on_wall_last_frame = player.is_on_wall()
		on_ceiling_last_frame = player.is_on_ceiling()
		
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * input.get_direction(), acceleration)
	
	
func is_input_active(player: CharacterBody2D, input: LRInput) -> bool:
	var left_wall_or_ceiling = on_wall_last_frame and not player.is_on_wall() or on_ceiling_last_frame and not player.is_on_ceiling()
	var is_input_after_left_collision = input.get_direction() and left_wall_or_ceiling 
	return input.just_pressed() or input.just_released() or is_input_after_left_collision
	
func init_accel_dict(player: CharacterBody2D, input: LRInput) -> void:
	accel_dict.final_speed = calc_final_speed(player, input.get_direction())
	accel_dict.acceleration_factor = 0.0
	
func get_acceleration(player: CharacterBody2D, delta: float) -> float:
	if accel_type == LinearTypes.DECREASING:
		accel_dict.initial_accel = calc_initial_accel(accel_dict, delta)
		
	accel_dict.offset = calc_offset(accel_dict, player.velocity.x, delta)
	increment_accel_factor()
	return calc_acceleration(accel_dict, delta)


func calc_acceleration(_accel_dict: Dictionary, delta: float) -> float:
	var acceleration: float = 2 * ((_accel_dict.final_speed * delta - _accel_dict.initial_accel * accel_time) / accel_time) * _accel_dict.accel_factor + _accel_dict.initial_accel
	return acceleration - _accel_dict.offset

func calc_final_speed(player: CharacterBody2D, direction: float) -> float:
	return absf(-1 * player.max_speed * direction + player.velocity.x)
	
## Used to calculate initial acceleration when acceleration is decreasing.
func calc_initial_accel(_accel_dict: Dictionary, delta: float) -> float:
	return 2 * _accel_dict.final_speed * (delta / accel_time)
	
func calc_offset(_accel_dict: Dictionary, initial_velocity: float,  delta: float) -> float:
	return (_accel_dict.final_speed * delta - initial_velocity * accel_time) / (accel_time * accel_time / delta)
	
func increment_accel_factor() -> void:
	accel_dict.accel_factor += 1 / accel_dict.ticks
