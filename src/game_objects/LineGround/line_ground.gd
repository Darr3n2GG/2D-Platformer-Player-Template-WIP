@tool
extends StaticBody2D

@export var line_color: Color = Color.BROWN:
	set(value):
		line_color = value
		set_line_color(value)
@export var is_viewport_width : bool = true
		
@onready var line_2d: Line2D = $Line2D


func _ready() -> void:
	set_line_color(line_color)
	if not Engine.is_editor_hint():
		if is_viewport_width:
			set_width_to_viewport()
			get_viewport().size_changed.connect(set_width_to_viewport)
	
func _physics_process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		var camera_2d = get_viewport().get_camera_2d()
		if camera_2d != null:
			global_position.x = camera_2d.global_position.x
	
func set_line_color(color_: Color) -> void:
	if is_instance_valid(line_2d):
		line_2d.default_color = color_
		
func set_line_width(width_: float) -> void:
	line_2d.points[0].x = width_ * -1
	line_2d.points[1].x = width_

func set_width_to_viewport() -> void:
	var viewport_width := get_viewport_rect().size.x
	set_line_width(viewport_width)
