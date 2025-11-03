class_name SimpleVerticalMovement extends VerticalMovementStrategy


@export var jump_velocity: float
@export var gravity: float
@export var use_default_gravity: bool:
	set(value):
		use_default_gravity = value
		if use_default_gravity:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _init(_jump_vel = 0.0, _gravity = 0.0, _use_default_g = false) -> void:
	jump_velocity = _jump_vel
	gravity = _gravity
	use_default_gravity = _use_default_g

func apply_jump(player: Player, is_input: bool, _delta: float) -> void:
	if player.is_on_floor() and player.is_jumping:
		player.is_jumping = false
	
	if is_input and player.is_on_floor():
		player.velocity.y = jump_velocity
		player.is_jumping = true
		
func apply_gravity(player: Player, delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
