@tool
class_name PolygonPlatform extends StaticBody2D


@export var color: Color:
	set(value):
		color = value
		if is_instance_valid(color):
			set_polygon_color(value)
		
@export var polygon: PackedVector2Array:
	set(value):
		polygon = value
		if is_instance_valid(polygon):
			set_polygon(value)


@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


var previous_polygon: PackedVector2Array
var previous_color: Color


func _ready() -> void:
	set_polygon_color(color)
	set_polygon(polygon)
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		handle_polygon_update()
		handle_color_update()
		
func handle_polygon_update() -> void:
	if previous_polygon != polygon:
		previous_polygon = polygon
		set_polygon(polygon)
		
func handle_color_update() -> void:
	if previous_color != color:
		previous_color = color
		set_polygon_color(color)

func set_polygon_color(color_: Color) -> void:
	polygon_2d.color = color_

func set_polygon(polygon_: PackedVector2Array) -> void:
	polygon_2d.polygon = polygon_
	collision_polygon_2d.polygon = polygon_
	
