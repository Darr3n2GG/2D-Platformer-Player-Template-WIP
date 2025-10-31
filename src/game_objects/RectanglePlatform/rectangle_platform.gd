@tool
class_name SquarePlatform extends PolygonPlatform

@export var size: Vector2:
	set(value):
		size = value
		polygon = size_to_vertex(value)

var previous_size: Vector2

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		handle_size_update()
		handle_color_update()
			
func handle_size_update() -> void:
	if previous_size != size:
		previous_size = size
		var polygon_ = size_to_vertex(size)
		set_polygon(polygon_)
		
func size_to_vertex(size_: Vector2) -> PackedVector2Array:
	var half_width = size_.x / 2
	var half_length = size_.y / 2
	var p1 = Vector2(half_width * -1, half_length)
	var p3 = Vector2(half_width, half_length * -1)
	var p2 = Vector2(p3.x, p1.y)
	var p4 = Vector2(p1.x, p3.y)
	return PackedVector2Array([p1, p2, p3, p4])
		
