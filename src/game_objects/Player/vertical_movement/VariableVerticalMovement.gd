class_name VariableVerticalMovement extends VerticalMovementStrategy


@export var jump_height: float
@export var collision_offset: float
@export var time_to_apex: float
@export var time_to_fall: float

var jump_velocity: float
var gravity: float


func apply_jump(player: Player, is_input: bool, _delta: float) -> void:
	if is_input and player.is_on_floor():
		jump_velocity = calculate_jump_velocity()
		player.velocity.y = jump_velocity
	

func apply_gravity(player: Player, delta: float) -> void:
	if not player.is_on_floor():
		if player.velocity.y >= 0:
			gravity = calculate_fall_gravity()
		else:
			gravity = calculate_jump_gravity()
			
		player.velocity.y += gravity * delta


func calculate_jump_velocity() -> float:
	var h = jump_height + collision_offset
	return ((2.0 * h) / time_to_apex) * -1.0

func calculate_jump_gravity() -> float:
	var h = jump_height + collision_offset
	return ((-2.0 * h) / (time_to_apex * time_to_apex)) * -1.0
	
func calculate_fall_gravity() -> float:
	var h = jump_height + collision_offset
	return ((-2.0 * h) / (time_to_fall * time_to_fall)) * -1.0
