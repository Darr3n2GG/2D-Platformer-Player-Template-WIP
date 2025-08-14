class_name QuadrilateralPolygonFactory extends PolygonFactory

var size: Vector2
var start: Vector2


func create_polygon() -> PackedVector2Array:
	polygon = PackedVector2Array([
		start,
		start + Vector2(size.x, 0),
		start + size,
		start + Vector2(0, size.y),
	])
	return polygon
		
