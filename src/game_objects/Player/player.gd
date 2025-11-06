class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy
@export var vertical_movement_strategy: VerticalMovementStrategy

var movement_enabled: bool = true
var jump_enabled: bool = true
var gravity_enabled: bool = true

#var is_jumping: bool


func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_jump(delta)
	handle_gravity(delta)
	move_and_slide()
	
func handle_movement(delta: float) -> void:
	if not movement_enabled:
		return
		
	accel_strategy.apply_acceleration(self, get_direction(), delta)
		
func handle_jump(delta: float) -> void:
	if not jump_enabled:
		return
	
	vertical_movement_strategy.apply_jump(self, Input.is_action_just_pressed("jump"), delta)
	
func handle_gravity(delta: float) -> void:
	if not gravity_enabled:
		return
	
	vertical_movement_strategy.apply_gravity(self, delta)
		
	
func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
