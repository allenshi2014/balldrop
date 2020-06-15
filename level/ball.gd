extends KinematicBody2D

var vel = Vector2()
var prevpos = Vector2()
var initalpos = Vector2() #get the inital postion to reset mars back after lost

signal stage_close

func _ready():
	connect("stage_close", get_tree().get_root().find_node("stage1_1"), "_on_ball_stage_close")
	#set image for ball
	var ball_texture1 = preload("res://image/ball/ball1.png")
	var ball_texture2 = preload("res://image/ball/ball2.png")
	var ball_texture3 = preload("res://image/ball/ball3.png")
	var ball_texture4 = preload("res://image/ball/ball4.png")
	
	if Global.ball_avator == "ball1":
		$sprite.set_texture(ball_texture1)
	elif Global.ball_avator == "ball2":
		$sprite.set_texture(ball_texture2)
	elif Global.ball_avator == "ball3":
		$sprite.set_texture(ball_texture3)
	elif Global.ball_avator == "ball4":
		$sprite.set_texture(ball_texture4)
	else:
		$sprite.set_texture(ball_texture1)
	
	prevpos = position
	initalpos = position
	

func _physics_process(delta):
	#yield(get_tree().create_timer(2), "timeout")
	#set rotation force
	if prevpos.x < position.x:
		rotation += 0.1
	elif prevpos.x > position.x:
		rotation -= 0.1
	else:
		rotation = 0

	
	if position == initalpos:
		reset_ball()
		
	if position.y > 1000:
		reset_ball()
		
	vel += Vector2(0, 20 * 1) * delta
	prevpos = position
	position += vel

	# manual collision for now
	var colliders = get_tree().get_nodes_in_group("line")
	for c in colliders:
		#print(c.collider_name)
		var p1 = c.a
		var p2 = c.b
		var norm = (p2-p1).tangent().normalized()
		
		#allen
		var coll = null
		if c.collider_name == "line":
			coll = Geometry.segment_intersects_segment_2d(prevpos, position, p1, p2)
		elif c.collider_name == "rock" or c.collider_name == "gate":
			coll = Geometry.is_point_in_polygon(position, c.collider_area)
			if coll == false:
				coll = null
		
		if coll != null:
			
			if c.collider_name == "gate":
				get_parent().find_node("gate").scale = Vector2(0.5, 0.5)
				queue_free()
				#go to next stage
				emit_signal("stage_close")
				var cover1 = get_parent().find_node("stage_cover1")
				var cover2 = get_parent().find_node("stage_cover2")
				var btn_next = get_parent().find_node("btn_next")
				cover1.scale = Vector2(100, 45)
				cover2.scale = Vector2(100, 45)
				btn_next.visible = true
			
				
			elif c.collider_name == "rock":
				#add break effect
				var shockwave = preload("res://level/shockwave.tscn").instance()
				shockwave.position = position
				shockwave.scale = Vector2(2, 2)
				shockwave.modulate = Color(0.5, 1, 0, 1)
				get_parent().add_child(shockwave)
				#add sound effect
				AudioPlayer.play_at("kick", position, 1)
				
				reset_ball()
				break

			elif c.collider_name == "line":
				if vel.dot(norm) > 0:
					norm = -norm
				#bounce force 
				var restitution = 1
				vel = (-vel.reflect(norm)).linear_interpolate(vel.slide(norm), 1-restitution)
				position = coll + norm * 0.1
				
			
				var shockwave = preload("res://level/shockwave.tscn").instance()
				shockwave.position = position
				#shockwave.modulate = $spr.modulate
				get_parent().add_child(shockwave)
				AudioPlayer.play_at("bell", position, 1)
			
			else:
				pass
				
func reset_ball():
	#add ball entry effect
	var entry = preload("res://level/ball_entry.tscn").instance()
	entry.position = initalpos
	entry.z_index = -1
	get_parent().add_child(entry)
	
	position = initalpos
	vel = Vector2()
