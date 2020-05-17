extends StaticBody2D

var a = Vector2()
var b = Vector2()
var collider_name = "gate"
var collider_area = PoolVector2Array()

func _ready():
	
	collider_area = $shape.get_polygon()
	
	var point_count = collider_area.size()
	for i in range(point_count):
		var p_point = position + collider_area[i]
		collider_area.set(i, p_point)
