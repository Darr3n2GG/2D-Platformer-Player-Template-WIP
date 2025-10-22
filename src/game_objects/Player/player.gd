class_name Player extends CharacterBody2D


@export var max_speed: float = 500.0
@export var accel_strategy: AccelStrategy

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -500
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
