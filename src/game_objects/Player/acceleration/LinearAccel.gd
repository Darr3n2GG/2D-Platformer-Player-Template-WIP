class_name LinearAccel extends AccelStrategy


enum LinearTypes { INCREASING, DECREASING }

@export var accel_type: LinearTypes
@export var accel_time: float
@export var decel_time: float
@export var turn_time: float

var active := false
var elapsed := 0.0
var v_start := 0.0
var v_target := 0.0
var a0 := 0.0
var k := 0.0
var t_accel := 0.0


func _init(_t_accel = 0.0, _t_decel = 0.0, _t_turn = 0.0) -> void:
	accel_time = _t_accel
	decel_time = _t_decel
	turn_time = _t_turn

func apply_acceleration(player: Player, direction: float, delta: float) -> void:
	var is_released_input := direction == 0 and just_released()
	if is_released_input:
		active = false
		return
		
	var desired_target = player.max_speed * direction
	if not active or not is_equal_approx(desired_target, v_target):
		start_acceleration(player, direction)

	if t_accel <= 0.0:
		player.velocity.x = player.max_speed * direction
		active = false
		return
		
	if active:
		elapsed += delta
		var t = elapsed
		var v_t = v_start + a0 * t + 0.5 * k * t * t

		if v_target > v_start:
			v_t = clamp(v_t, v_start, v_target)
		else:
			v_t = clamp(v_t, v_target, v_start)

		player.velocity.x = v_t
		
		# Velocity will still be clamped so floating point precision issue here is not a big deal.
		if elapsed >= t_accel:
			player.velocity.x = v_target
			active = false
	
			
func start_acceleration(player: Player, direction: float) -> void:
	v_start = player.velocity.x
	v_target = player.max_speed * direction
	t_accel = get_final_time(player.velocity.x, direction)
	elapsed = 0.0
	active = true

	var dv = v_target - v_start
	if is_equal_approx(dv, 0.0):
		active = false
		return

	match accel_type:
		LinearTypes.DECREASING:
			a0 = 2.0 * dv / t_accel
			k = -a0 / t_accel
		LinearTypes.INCREASING:
			a0 = 0.0
			k = 2.0 * dv / (t_accel * t_accel)

func get_final_time(velocity_x: float, direction: float) -> float:
	var is_turning = sign(velocity_x) != sign(direction) and velocity_x != 0.0
	if direction == 0.0:
		return decel_time
	elif is_turning:
		return turn_time
	else:
		return accel_time

			
func just_pressed() -> bool:
	return Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")

func just_released() -> bool:
	return Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right")
