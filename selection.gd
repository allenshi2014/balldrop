extends Node

signal swipe
#var swipe_start = null
var minimum_drag = 100

var swipe_start = null

func _ready():
	swipe_start = null
	
	
func _process(_delta):
	
	var msg = ""
	var msg2 = ""
	for child in $sprites.get_children():
		#get space between center(x=650) and each item
		var space = abs(child.global_position.x - 650)
		if space <= 150 and space >= 50:
			var increment = Vector2(0.002, 0.002)
			child.scale = Vector2(0.3, 0.3) + (150 - space) * increment
			
		msg += String(child.global_position.x) + " / "
		msg2 += String(space) + " / "
	$label.text = msg
	$label2.text = msg2
	
	if swipe_start != null:
		var swipe_now = $cam.get_global_mouse_position()
		var distance = swipe_now.x - swipe_start.x
		$sprites.position.x += distance / 50
		
	
	
func _input(event):
	
	if event is InputEventMouseButton:
		
		if event.pressed and event.button_index == BUTTON_LEFT:
			swipe_start = $cam.get_global_mouse_position()
		elif event.button_index == BUTTON_LEFT:
			_calculate_swipe($cam.get_global_mouse_position())
			swipe_start = null
			
		
		
		
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			emit_signal("swipe", "right")
			
			$sprites.position.x += 10
			print("right")
		else:
			emit_signal("swipe", "left")
			
			$sprites.position.x -= 10
			print("left")


func _on_btn_back_pressed():
	get_tree().change_scene("res://menu.tscn")
