class_name ConstAccel extends AccelStrategy


@export var accel_time: float
@export var decel_time: float
@export var turn_time: float

var t_accel: float


func _init(_t_accel = 0.0, _t_decel = 0.0, _t_turn = 0.0) -> void:
	accel_time = _t_accel
	decel_time = _t_decel
	turn_time = _t_turn

func apply_acceleration(player: Player, direction: float, delta: float) -> void:
	set_t_accel(player.velocity.x, direction)
	var ticks := t_accel / delta
	
	var acceleration = player.max_speed * (1 / ticks)
	player.velocity.x = move_toward(player.velocity.x, player.max_speed * direction, acceleration)
	
func set_t_accel(velocity_x: float, direction: float) -> void:
	if just_pressed() or just_released():
		var is_turning = sign(velocity_x) != sign(direction) and velocity_x != 0.0
		if direction == 0.0:
			t_accel = decel_time
		elif is_turning:
			t_accel = turn_time
		else:
			t_accel = accel_time
		
func just_pressed() -> bool:
	return Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")

func just_released() -> bool:
	return Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right")
