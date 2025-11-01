@abstract
class_name JumpStrategy extends Resource


# TODO: make data a general purpose physics data? not sure
# TODO: add a way to get input from the player node instead of in physics logic
@abstract func apply_jump(player: Player, gravity_data: Dictionary, delta: float) -> void

@abstract func get_data() -> Dictionary
