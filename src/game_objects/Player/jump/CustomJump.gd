class_name CustomJump extends JumpStrategy


@export var jump_velocity: float


func apply_jump(player: Player, _gravity_data: Dictionary, _delta: float) -> void:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_velocity
	
func get_data() -> Dictionary:
	return {}
