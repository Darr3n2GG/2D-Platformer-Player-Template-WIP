class_name Player extends CharacterBody2D


@export var accel_time: float = 0.0
@export var max_speed: float = 500.0
@export var accel_type: accel_types = accel_types.DECREASING

enum accel_types { INCREASING, DECREASING }

var acceleration: float
var time_passed: float


func _physics_process(delta: float) -> void:
	update_acceleration(delta)
	move()
	
	if not is_on_floor():
		velocity.y += 9.81
		
	move_and_slide()
	
func move() -> void:
	velocity.x = move_toward(velocity.x, max_speed * get_direction(), acceleration)
	
func update_acceleration(_delta: float) -> void:
	if accel_time == 0.0:
		acceleration = max_speed
	elif accel_time > 0.0:
		if accel_type == accel_types.DECREASING:
			acceleration = max_speed / accel_time * _delta
		elif accel_type == accel_types.INCREASING:
			if time_passed > accel_time:
				time_passed = 0.0
			else:
				time_passed += _delta
			
			var y = -time_passed + 1
			acceleration = max_speed / accel_time * _delta

func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")
