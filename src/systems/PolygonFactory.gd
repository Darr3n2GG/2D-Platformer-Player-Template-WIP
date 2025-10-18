## Virtual base class for all polygon factories.
## Extend this class and override its methods to implement a polygon factory.
class_name PolygonFactory extends RefCounted

# Should this be here?
var polygon: PackedVector2Array


func create_polygon() -> PackedVector2Array:
	return polygon
