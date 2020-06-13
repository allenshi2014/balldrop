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
		#get new position after scaling
		var p_point = position + collider_area[i] * collider_scale
		#get new position after rotation
#		var r = p_point.distance_to($sprite.position)
#		var angle = p_point.angle_to_point($sprite.position) + deg2rad(get_rotation())
#		var x = r * cos(abs(angle))
#		var y = r * sin(abs(angle))
#		p_point = Vector2(x, y)
		#reset the postion after scaling and rotation
		collider_area.set(i, p_point)


		#get points postion after rotation
		var r = p_point.distance_to($sprite.position)
		var angle_ini = rad2deg(p_point.angle_to_point($sprite.position))
		var angle_add = rad2deg(get_rotation())
		var angle = angle_ini + angle_add
		var x = r * cos(abs(deg2rad(angle)))
		var y = r * sin(abs(deg2rad(angle)))
		
		print(String(p_point))
		print(String(i) + ":" + String(x) + "," + String(y))
