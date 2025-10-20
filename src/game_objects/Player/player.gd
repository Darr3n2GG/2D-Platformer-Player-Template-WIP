class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lr_input = LRInput.new("move_left", "move_right")


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
