extends StaticBody2D

var a = Vector2()
var b = Vector2()
var collider_name = "star"
var collider_area = PoolVector2Array()
var collider_scale = 1


func _ready():
	
	collider_area = $shape.get_polygon()
	collider_scale = self.scale
	
	var point_count = collider_area.size()
	for i in range(point_count):
		var p_point = position + collider_area[i] * collider_scale
		collider_area.set(i, p_point)

func _process(delta):
	rotation += 0.01
