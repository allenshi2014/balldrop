extends Node

var line_length = 150
var current_line = null
var current_line_shadow = null
var p1 = Vector2()
var p2 = p1
var last_mouse_pos = Vector2()


func _ready():
	pass
	#yield(get_tree().create_timer(1), "timeout")


func _process(delta):
	
	last_mouse_pos = $cam.get_global_mouse_position()
	p2 = last_mouse_pos
	
	if current_line != null and p1.distance_to(p2) <= line_length and p1.distance_to(p2) >= 10:
		current_line_shadow.set_ends_shadow(p1, p2)
		current_line.set_ends(p1, p2)
		
	$line_count_txt.text =  String(Global.line_count)
	
	
func _input(event):
	
	if (event.is_action_released("ui_cancel")):
		get_tree().quit()

			
	if event is InputEventMouseButton:

		if event.pressed and event.button_index == BUTTON_LEFT:

			p1 = last_mouse_pos
			p2 = p1
			
			current_line = preload("res://line.tscn").instance()
			current_line.set_ends(p1, p2)
			#add_child(current_line)
			
			#showing the shadow line without bounce
			current_line_shadow = preload("res://line.tscn").instance()
			current_line_shadow.set_ends_shadow(p1, p2)
			add_child(current_line_shadow)
			
		#allen 
		elif event.button_index != BUTTON_RIGHT:
			#add line when released
			add_child(current_line)

			if  p1.distance_to(p2) >= 10:
				#print(String(line_length))
				Global.line_count += 1

			current_line = null

		else:
			current_line = null


