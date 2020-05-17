extends StaticBody2D

var a = Vector2()
var b = Vector2()
#var c = Vector2()
var collider_name = "gate"
var collider_area = PoolVector2Array()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#a = position + Vector2(-10, -10)
	#b = position + Vector2(10, -10)
	#c = position + Vector2(0, 10)
	
	a = position + Vector2(-50, 0)
	b = position + Vector2(100, 00)
	
	collider_area = get_node("CollisionShape2D").get_polygon()
	
	var point_count = collider_area.size()
	for i in range(point_count):
		var p_point = position + collider_area[i]
		collider_area.set(i, p_point)
	#collider_area = $CollisionShape2D.get_polygon()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
