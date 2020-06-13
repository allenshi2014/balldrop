extends StaticBody2D

var a = Vector2()
var b = Vector2()
var collider_name = "rock"
var collider_area = PoolVector2Array()
var collider_scale = 1

func _ready():
	
	collider_area = $shape.get_polygon()
	collider_scale = self.scale
	
	var point_count = collider_area.size()
	for i in range(point_count):
		var p_point = position + collider_area[i] * collider_scale
		collider_area.set(i, p_point)

		#get points postion after rotation
		var r = p_point.distance_to($sprite.position)
		var angle = p_point.angle_to_point($sprite.position) + $sprite.get_rotation()
		var x = r * cos(abs(angle))
		var y = r * sin(abs(angle))
		print(String(i) + ":" + String(x) + "," + String(y))
		print(String(p_point))
		print(String(rad2deg(p_point.angle_to_point($sprite.position))))
