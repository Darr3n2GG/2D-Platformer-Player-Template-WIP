class_name BetterVerticalMovement extends VerticalMovementStrategy


@export var jump_height: float
@export var height_offset: float
@export var time_to_apex: float
@export var time_to_fall: float

@export_group("Low Jump")
enum low_jump_types {GRAVITY_MULTIPLIER, JUMP_CUT}
@export var low_jump_type: low_jump_types
@export var low_jump_multiplier: float = 1.0
@export var low_jump_height: float

var jump_velocity: float
var gravity: float

var is_released_jump_last_frame: bool


func _init(_h_jump = 0.0, _offset = 0.0, _t_apex = 0.0, _t_fall = 0.0) -> void:
	jump_height = _h_jump
	height_offset = _offset
	time_to_apex = _t_apex
	time_to_fall = _t_fall
	

func apply_jump(player: Player, is_input: bool, _delta: float) -> void:	
	if is_input and player.is_on_floor():
		jump_velocity = calculate_base_jump_velocity()
		player.velocity.y = jump_velocity
	
	if low_jump_type == low_jump_types.JUMP_CUT:
		jump_cut(player)
	
	update_is_released_jump_last_frame(is_input and player.is_on_floor())

func jump_cut(player: Player) -> void:
	var low_jump_velocity := calculate_low_jump_velocity()
	if player.velocity.y < low_jump_velocity and Input.is_action_just_released("jump"):
		player.velocity.y = low_jump_velocity
		
func update_is_released_jump_last_frame(is_jumped: bool) -> void:
	if is_jumped:
		is_released_jump_last_frame = false
		
	if not is_released_jump_last_frame:
		is_released_jump_last_frame = Input.is_action_just_released("jump")
		
func calculate_base_jump_velocity() -> float:
	var h = jump_height + height_offset
	return calculate_jump_velocity(h, time_to_apex)
	
func calculate_low_jump_velocity() -> float:
	var h = low_jump_height + height_offset
	return calculate_jump_velocity(h, time_to_apex)
	
func calculate_jump_velocity(h: float, t: float) -> float:
	return ((2.0 * h) / t) * -1.0


func apply_gravity(player: Player, delta: float) -> void:
	if not player.is_on_floor():
		gravity = get_gravity(player.velocity.y >= 0)
		player.velocity.y += gravity * delta
		
func get_gravity(is_falling: bool) -> float:
	if is_falling:
		return calculate_fall_gravity()
	else:
		if is_released_jump_last_frame and low_jump_type == low_jump_types.GRAVITY_MULTIPLIER:
			return calculate_jump_gravity() * low_jump_multiplier
			
		return calculate_jump_gravity()
	
func calculate_jump_gravity() -> float:
	var h = jump_height + height_offset
	return calculate_gravity(h, time_to_apex)
	
func calculate_fall_gravity() -> float:
	var h = jump_height + height_offset
	return calculate_gravity(h, time_to_fall)
	
func calculate_gravity(h: float, t: float) -> float:
	return ((-2.0 * h) / (t * t)) * -1.0
