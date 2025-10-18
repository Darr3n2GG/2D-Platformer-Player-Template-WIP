class_name PlayerCamera extends Camera2D

@export var player_node: CharacterBody2D
@export var stop_speed: float = 4.5
@export var walk_speed: float = 5.0
@export var front_distance: float = 50.0
@export var jump_speed: float = 4.0
@export var fall_speed: float = 15.0

var last_horizontal_input: int = 0
var is_input: bool


func _ready() -> void:
	global_position = player_node.global_position	

func _physics_process(delta: float) -> void:
	if not is_input and get_direction():
		last_horizontal_input = sign(get_direction())
		is_input = true

	lerp_camera(delta)

	if just_released_last_input():
		is_input = false

func lerp_camera(delta: float) -> void:
	var target_pos = player_node.global_position
	target_pos.x += front_distance * last_horizontal_input
		
	var diff = target_pos - global_position
	if diff.length() > 1:
		var walking: bool = diff.x > 0 and player_node.velocity.x != 0
		var horizontal_speed := walk_speed if walking else stop_speed
		global_position.x += diff.x * delta * horizontal_speed
		
		var falling: bool = diff.y > 0 and player_node.velocity.y > 0
		var vertical_speed := fall_speed if falling else jump_speed
		global_position.y += diff.y * delta * vertical_speed

func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")

func just_released_last_input() -> bool:
	if last_horizontal_input == 1 and Input.is_action_just_released("move_right"):
		return true
	elif last_horizontal_input == -1 and Input.is_action_just_released("move_left"):
		return true
	else:
		return false
