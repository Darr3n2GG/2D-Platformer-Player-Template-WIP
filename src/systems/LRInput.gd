class_name LRInput extends RefCounted

var left: String
var right: String


func _init(left_input: String, right_input: String) -> void:
	left = left_input
	right = right_input

func get_direction() -> float:
	return Input.get_axis(left, right)

func just_pressed() -> bool:
	return Input.is_action_just_pressed(left) or Input.is_action_just_pressed(right)
	
func just_released() -> bool:
	return Input.is_action_just_released(left) or Input.is_action_just_released(right)
