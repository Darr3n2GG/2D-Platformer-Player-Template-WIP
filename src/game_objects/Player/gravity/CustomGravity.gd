class_name CustomGravity extends GravityStrategy


@export var gravity: float
@export var use_default: bool:
	set(value):
		use_default = value
		if use_default:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func apply_gravity(player: Player, _jump_data: Dictionary, delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	
func get_data() -> Dictionary:
	return {}
