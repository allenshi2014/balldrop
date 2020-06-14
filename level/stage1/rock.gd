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
	
		var p_point = collider_area[i]
		#get new postion after rotation
		var r = p_point.distance_to($sprite.position)
		var angle_ini = rad2deg(p_point.angle_to_point($sprite.position))
		var angle_add = rad2deg(get_rotation())
		var angle = angle_ini + angle_add
		var x = r * cos(deg2rad(angle))
		var y = r * sin(deg2rad(angle))
		p_point = Vector2(x, y)
		
		#get new position after scaling
		#<position> for this node's position in parent note
		p_point = position + p_point * collider_scale
		
		#reset the postion after scaling and rotation
		collider_area.set(i, p_point)
