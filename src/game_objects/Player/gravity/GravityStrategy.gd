@abstract
class_name GravityStrategy extends Resource


# TODO: make data a general purpose physics data? not sure
# TODO: add a way to get input from the player node instead of in physics logic
@abstract func apply_gravity(player: Player, jump_data: Dictionary, delta: float) -> void

@abstract func get_data() -> Dictionary
