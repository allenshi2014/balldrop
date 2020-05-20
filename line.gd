extends StaticBody2D

var a = Vector2()
var b = Vector2()
var b_limit = Vector2()

var collider_name = "line"

var timer = Timer.new()
var line_lifecyle = 5
var line_shadow = null
var line_ready = true

func _ready():

	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_wait_time(line_lifecyle)
	add_child(timer)
	#timer.start()

func _process(_delta):
	if line_ready == true:
		timer.start()
		line_ready = false
	
	
func _on_Timer_timeout():
	
	if line_shadow == false:
		queue_free()
		Global.line_count -= 1
		get_parent().get_node("line_count_txt").text = String(Global.line_count)
	else:
		queue_free()


func set_ends_shadow(p1, p2):

	line_shadow = true
	line_ready = true
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
	
	line_shadow = false
	line_ready = true
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
			Global.line_count -= 0.5
			get_parent().get_node("line_count_txt").text = String(Global.line_count)

