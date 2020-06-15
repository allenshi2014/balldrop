extends Node

var line_length = 300
var current_line = null
var current_line_shadow = null
var p1 = Vector2()
var p2 = p1
var last_mouse_pos = Vector2()


func _ready():
	pass
	#OS.set_window_fullscreen(true)
	#yield(get_tree().create_timer(1), "timeout")


func _process(_delta):
	
	last_mouse_pos = $cam.get_global_mouse_position()
	p2 = last_mouse_pos
	
	if current_line != null and p1.distance_to(p2) <= line_length and p1.distance_to(p2) >= 20:
		
		current_line_shadow.set_ends_shadow(p1, p2)
		current_line.set_ends(p1, p2)
		
	$line_count_txt.text =  String(Global.line_count)
	
	
func _input(event):
	
	if (event.is_action_released("ui_cancel")):
		get_tree().quit()

			
	if event is InputEventMouseButton:

		if event.pressed and event.button_index == BUTTON_LEFT:

			p1 = $cam.get_global_mouse_position()
			p2 = p1
			
			current_line = preload("res://level/line.tscn").instance()
			current_line.set_ends(p1, p2)
			#add_child(current_line)
			
			#showing the shadow line without bounce
			current_line_shadow = preload("res://level/line.tscn").instance()
			current_line_shadow.set_ends_shadow(p1, p2)
			add_child(current_line_shadow)
			
		#add line when button_left released
		elif event.button_index == BUTTON_LEFT:
			
			add_child(current_line)

			if  p1.distance_to(p2) >= 20:
				#print(String(line_length))
				Global.line_count += 1

			current_line = null

		else:
			current_line = null

	
func _on_btn_back_pressed():
	get_tree().change_scene("res://menu.tscn")


func _on_btn_next_pressed():
	get_tree().change_scene("res://level/stage1/stage1_2.tscn")


func _on_btn_reset_pressed():
	get_tree().change_scene("res://level/stage1/stage1_1.tscn")
