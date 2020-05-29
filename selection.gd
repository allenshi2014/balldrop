extends Node

signal swipe
#var swipe_start = null
var minimum_drag = 100

var swipe_start = null

func _ready():
	swipe_start = null

func _process(_delta):
	
	
	var child1 = $sprites.get_child(0)
	for child in $sprites.get_children():
		var space = child.position.x - 600
		
		
	
	if swipe_start != null:
		var swipe_now = $cam.get_global_mouse_position()
		var distance = swipe_now.x - swipe_start.x
		$sprites.position.x += distance / 30
		
		if child1.scale <= Vector2(5, 5):
			child1.scale += Vector2(0.01, 0.01)
		
	elif swipe_start == null and child1.scale >= Vector2(0.3, 0.3):
		child1.scale -= Vector2(0.01, 0.01)
		
	else:
		pass


#func _process(event):
#	if event.is_action_pressed("click"):
#		swipe_start = $cam.get_global_mouse_position()
#		var distance = swipe_start.x - $sprites.position.x
#		$sprites.position.x += distance
	
	
	
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		swipe_start = $cam.get_global_mouse_position()
	if event.is_action_released("click"):
		swipe_start = null
		
		#_calculate_swipe($cam.get_global_mouse_position())
		
		
		
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	print(swipe)
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			emit_signal("swipe", "right")
			print("right")
		else:
			emit_signal("swipe", "left")
			print("left")
