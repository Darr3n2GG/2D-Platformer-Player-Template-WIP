class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy
@export var jump_strategy: JumpStrategy
@export var gravity_strategy: GravityStrategy

var movement_enabled: bool = true
var jump_enabled: bool = true
var gravity_enabled: bool = true


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
	
	var gravity_data := gravity_strategy.get_data()
	jump_strategy.apply_jump(self, gravity_data, delta)
	
func handle_gravity(delta: float) -> void:
	if not gravity_enabled:
		return
	
	var jump_data := jump_strategy.get_data()
	gravity_strategy.apply_gravity(self, jump_data, delta)
		
	
func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
