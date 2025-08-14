@tool
class_name QuadrilateralPolygon2D extends Polygon2D


@export var size: Vector2:
	set(value):
		size = value
		polygon_factory.size = value
		polygon = polygon_factory.create_polygon()
		
@export var centered: bool:
	set(value):
		centered = value
		polygon_factory.start = Vector2.ZERO - (size/2) if centered else Vector2.ZERO
		polygon = polygon_factory.create_polygon()
		
var polygon_factory := QuadrilateralPolygonFactory.new()
