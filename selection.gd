extends Node

signal swipe
var minimum_drag = 100
#sliding
var swipe_start = null
var swipe_right_released = false
var swipe_left_released = false
var slide_distance = 0
var slide_increment = 10
var space = 0
	
func _process(delta):

	#increase/decrease items while moving
	$btn_play.visible = false
	for child in $sprites.get_children():
		#get space between center(x=650) and each item
		space = abs(child.global_position.x - 650)
		#scaling when in range
		if space <= 150 and space >= 50:
			var increment = Vector2(0.005, 0.005)
			child.scale = Vector2(1, 1) + (150 - space) * increment
		#show play button when in range
		if space <= 50 and space >= 0:
			$btn_play.visible = true
			#pass the selected ball name to ball.gd
			Global.ball_avator = child.name

	#moving items while mouse moves
	if swipe_start != null:
		var swipe_now = $cam.get_global_mouse_position()
		var distance = swipe_now.x - swipe_start.x
		$sprites.position.x += distance / 50

#	#sliding after swipe with gradual increment
#	if swipe_left_released and slide_distance <= 150 and slide_increment > 0 and swipe_start == null:
#		$sprites.position.x -= slide_increment
#		slide_distance += slide_increment
#		slide_increment -= 0.1
#	elif swipe_right_released and slide_distance <= 150 and slide_increment > 0 and swipe_start == null:
#		$sprites.position.x += slide_increment
#		slide_distance += slide_increment
#		slide_increment -= 0.1
#	else:
#		slide_distance = 0
#		slide_increment = 10
#		swipe_right_released = false
#		swipe_left_released = false
	
	
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
			swipe_right_released = true
		else:
			emit_signal("swipe", "left")
			swipe_left_released = true


func _on_btn_back_pressed():
	get_tree().change_scene("res://menu.tscn")


func _on_btn_play_pressed():
	get_tree().change_scene("res://level/stage1/stage1_1.tscn")
