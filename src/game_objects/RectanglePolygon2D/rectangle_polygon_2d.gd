@tool
class_name RectanglePolygon2D extends Polygon2D


@export var size := Vector2(20,20):
	set(value):
		size = value
		polygon_factory.size = value
		if centered:
			polygon_factory.center_polygon()
		polygon = polygon_factory.create_polygon()
		
@export var centered := true:
	set(value):
		centered = value
		if centered:
			polygon_factory.center_polygon()
		else:
			polygon_factory.start = Vector2.ZERO
		polygon = polygon_factory.create_polygon()
		
var polygon_factory := RectanglePolygonFactory.new()
