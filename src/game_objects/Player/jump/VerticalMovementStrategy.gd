@abstract
class_name VerticalMovementStrategy extends Resource


@abstract func apply_jump(player: Player, is_input: bool, delta: float) -> void

@abstract func apply_gravity(player: Player, delta: float) -> void
