class_name Player extends CharacterBody2D


@export var accel_time: float = 0.0
@export var max_speed: float = 500.0
@export var accel_type: accel_types = accel_types.ZERO

enum accel_types { ZERO, CONSTANT, INCREASING, DECREASING }

var acceleration: float
var time_passed: int
var offset: float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	update_acceleration(delta)
	move()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func move() -> void:
	if accel_type == accel_types.ZERO or accel_type == accel_types.CONSTANT:
		velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration)
	elif accel_type == accel_types.INCREASING:
		velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration) + offset * get_direction()
	elif accel_type == accel_types.DECREASING:
		velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration + offset)
	if acceleration != 0.0:
		print("velocity: " + str(velocity.x))
		print("\n")

	
func update_acceleration(_delta: float) -> void:
	var t := accel_time * 60
	
	if accel_type == accel_types.INCREASING:
		if time_passed < t and get_direction():
			time_passed += 1
		elif time_passed > 0 and not get_direction():
			time_passed -= 1
			
		time_passed = clampi(time_passed, 0, t)
	
	if accel_type == accel_types.ZERO and accel_time == 0.0:
		acceleration = max_speed
	elif accel_type == accel_types.CONSTANT and accel_time > 0.0:
		acceleration = max_speed / accel_time * _delta
	elif accel_type == accel_types.INCREASING:
		acceleration = 2 * max_speed / (t * t) * time_passed
		offset = -1 * time_passed * max_speed / (t * t)
	elif accel_type == accel_types.DECREASING:
		acceleration = (2 * max_speed / t) - (2 * max_speed / (t * t)) * time_passed
		offset = time_passed * max_speed / (t * t)
	
	if accel_type == accel_types.DECREASING:
		if time_passed < t and get_direction():
			time_passed += 1
		elif time_passed > 0 and not get_direction():
			time_passed -= 1
			
		time_passed = clampi(time_passed, 0, t)
		
	if not get_direction() and velocity.x == 0.0:
		acceleration = 0.0
	
	if acceleration != 0.0:
		print("acceleration: " + str(acceleration))
		print("offset: " + str(offset))
		print("time_passed: " + str(time_passed))

func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
