class_name Player extends CharacterBody2D


@export var accel_time: float = 0.0
@export var max_speed: float = 500.0
@export var accel_type: accel_types = accel_types.ZERO

enum accel_types { ZERO, CONSTANT, INCREASING, DECREASING }

var acceleration: float
var time_passed: int
var offset: float
var current_direction: float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ticks = accel_time * 60


func _physics_process(delta: float) -> void:
	update_acceleration(delta)
	move()
	
	if acceleration != 0.0:
		print("acceleration: " + str(acceleration))
		print("offset: " + str(offset))
		print("time_passed: " + str(time_passed))
		print("velocity: " + str(velocity.x))
		print("current_direction: " + str(current_direction))
		print("\n")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func move() -> void:
	if accel_type == accel_types.ZERO or accel_type == accel_types.CONSTANT:
		velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration)
	elif accel_type == accel_types.INCREASING or accel_type == accel_types.DECREASING:
		velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration + offset)

	
func update_acceleration(_delta: float) -> void:
	if accel_type == accel_types.DECREASING or accel_type == accel_types.INCREASING:
		if current_direction == 0.0:
			current_direction = get_direction()
		
		if time_passed < ticks and get_direction():
			time_passed += 1
		elif time_passed > 0 and not get_direction():
			time_passed -= 1
			
		time_passed = clamp(time_passed, 0, ticks)
	
	if accel_type == accel_types.ZERO and accel_time == 0.0:
		acceleration = max_speed
	elif accel_type == accel_types.CONSTANT and accel_time > 0.0:
		acceleration = max_speed / accel_time * _delta
	elif accel_type == accel_types.INCREASING:
		acceleration = 2 * max_speed / (ticks * ticks) * time_passed
		if get_direction():
			offset = -1 * max_speed / (ticks * ticks)
		else:
			offset = max_speed / (ticks * ticks)
	elif accel_type == accel_types.DECREASING:
		acceleration = (2 * max_speed / ticks) - (2 * max_speed / (ticks * ticks)) * time_passed
		if get_direction():
			offset = max_speed / (ticks * ticks)
		else:
			offset = -1 * max_speed / (ticks * ticks)

	if not get_direction() and velocity.x == 0.0:
		acceleration = 0.0
	

func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
