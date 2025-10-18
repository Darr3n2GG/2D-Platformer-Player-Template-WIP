## NOTE: All exportable variables should be created and exported in your player node.
class_name PlayerMovement extends Node

# Exportable variables
var max_speed: float

var velocity_x: float

var player: CharacterBody2D
var lr_input := LRInput.new("move_left", "move_right")


func _ready() -> void:
	await get_parent().ready
	player = get_parent()
	
	max_speed = player.max_speed

func _physics_process(delta: float) -> void:
	handle_input(delta)
	player.velocity.x = velocity_x

func handle_input(_delta: float) -> void:
	var acceleration := max_speed
	velocity_x = move_toward(velocity_x, max_speed * lr_input.get_direction(), acceleration)
