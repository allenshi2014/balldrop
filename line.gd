extends StaticBody2D

var a = Vector2()
var b = Vector2()
var collider_name = "line"

func set_ends_shadow(p1, p2):

	a = p1
	b = p2
	# update the capsule
	$shape.shape.height = a.distance_to(b)
	$shape.position = (a + b) / 2
	$shape.rotation = a.angle_to_point(b) + PI / 2
	# update the sprite
	# (using a sprite so we get anti aliasing)
	$spr.position = (a + b) / 2
	$spr.rotation = $shape.rotation + PI / 2
	$spr.scale = Vector2(a.distance_to(b), 1)
	#grey color for shadow line
	$spr.modulate = Color(0.75, 0.75, 0.75, 1)
	#set no bounce 
	a = Vector2(0, 0)
	b = a
	

func set_ends(p1, p2):

	a = p1
	b = p2
	# update the capsule
	$shape.shape.height = a.distance_to(b)
	$shape.position = (a + b) / 2
	$shape.rotation = a.angle_to_point(b) + PI / 2
	# update the sprite
	# (using a sprite so we get anti aliasing)
	$spr.position = (a + b) / 2
	$spr.rotation = $shape.rotation + PI / 2
	$spr.scale = Vector2(a.distance_to(b), 1)


func _on_line_input_event(_viewport, event, _shape_idx):

	# delete line when right clicked
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_RIGHT:
			queue_free()
			#allen
			Global.line_count -= 0.5
			get_parent().get_node("line_count_txt").text = String(Global.line_count)

