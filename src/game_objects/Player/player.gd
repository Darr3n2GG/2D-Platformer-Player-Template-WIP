class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy

var movement_enabled: bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	handle_horizontal_movement(delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -500
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func handle_horizontal_movement(delta: float) -> void:
	if not movement_enabled:
		return
		
	accel_strategy.apply_acceleration(self, get_direction(), delta)
	
	
func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
