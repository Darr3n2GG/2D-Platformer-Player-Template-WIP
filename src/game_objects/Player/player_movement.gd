## Player component that provides horizontal movement.
class_name PlayerMovement extends Node

# Exportable variables
# NOTE: All exportable variables should be created and exported in your player node.
var max_speed: float
var accel_strategy: AccelStrategy

var velocity_x: float
var enabled: bool = true

var player: CharacterBody2D
var lr_input := LRInput.new("move_left", "move_right")


func _ready() -> void:
	await get_parent().ready
	player = get_parent()
	
	max_speed = player.max_speed
	accel_strategy = player.accel_strategy

func _physics_process(delta: float) -> void:
	if not enabled:
		return
		
	handle_input(delta)
	player.velocity.x = velocity_x

func handle_input(delta: float) -> void:
	accel_strategy.apply_acceleration(self, lr_input, delta)
