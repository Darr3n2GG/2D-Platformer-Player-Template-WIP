class_name SimpleVerticalMovement extends VerticalMovementStrategy


@export var jump_velocity: float
@export var gravity: float
@export var use_default_gravity: bool:
	set(value):
		use_default_gravity = value
		if use_default_gravity:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_group("Low Jump")
enum low_jump_types {GRAVITY_MULTIPLIER, JUMP_CUT}
@export var low_jump_type: low_jump_types
@export var low_jump_multiplier: float = 1.0
@export var low_jump_velocity: float

var is_released_jump_last_frame: bool


func _init(_jump_vel = 0.0, _gravity = 0.0, _use_def_g = false) -> void:
	jump_velocity = _jump_vel
	gravity = _gravity
	use_default_gravity = _use_def_g

func apply_jump(player: Player, is_input: bool, _delta: float) -> void:	
	if is_input and player.is_on_floor():
		player.velocity.y = jump_velocity
		
	if low_jump_type == low_jump_types.JUMP_CUT:
		jump_cut(player)
		
	update_is_released_jump_last_frame(is_input and player.is_on_floor())

func jump_cut(player: Player) -> void:
	if player.velocity.y < low_jump_velocity and Input.is_action_just_released("jump"):
		player.velocity.y = low_jump_velocity
		
func update_is_released_jump_last_frame(is_jumped: bool) -> void:
	if is_jumped:
		is_released_jump_last_frame = false
		
	if not is_released_jump_last_frame:
		is_released_jump_last_frame = Input.is_action_just_released("jump")
		
		
func apply_gravity(player: Player, delta: float) -> void:
	if player.is_on_floor():
		return
	
	var final_gravity: float
	if is_released_jump_last_frame and low_jump_type == low_jump_types.GRAVITY_MULTIPLIER:
		final_gravity = gravity * low_jump_multiplier
	else:
		final_gravity = gravity
	player.velocity.y += final_gravity * delta
	

		
