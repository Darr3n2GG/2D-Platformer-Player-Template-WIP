class_name RectanglePolygonFactory extends RefCounted

var size: Vector2
var start: Vector2
var polygon: PackedVector2Array


func create_polygon() -> PackedVector2Array:
	polygon = PackedVector2Array([
		start,
		start + Vector2(size.x, 0),
		start + size,
		start + Vector2(0, size.y),
	])
	return polygon
		
func center_polygon() -> void:
	start = Vector2.ZERO - (size/2)
