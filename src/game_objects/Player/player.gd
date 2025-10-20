class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy
@export var decel_strategy: AccelStrategy
# NOTE: If deceleration is instant, turning will have low chance of triggering.
#       Only happens when perfect change to opposite direction.
@export var turn_strategy: AccelStrategy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lr_input = LRInput.new("move_left", "move_right")


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
