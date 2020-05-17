extends KinematicBody2D

var vel = Vector2()
var prevpos = Vector2()
var initalpos = Vector2() #get the inital postion to reset mars back after lost
var sound

var notes = [] # TODO generate this globally

func _ready():
	prevpos = position
	initalpos = position

func _physics_process(delta):
	yield(get_tree().create_timer(2), "timeout")
	
	if position.y > 1000:
		#queue_free()
		#reset the position
		position = initalpos
		vel = Vector2()
		
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
			elif coll == true:
				pass
		
		if coll != null:
			
			if c.collider_name == "rock":
				#add break effect
				var shockwave = preload("res://shockwave.tscn").instance()
				shockwave.position = position
				shockwave.scale = Vector2(2, 2)
				shockwave.modulate = Color(0.5, 1, 0, 1)
				get_parent().add_child(shockwave)
				AudioPlayer.play_at("kick", position, 1)
				
				position = initalpos
				vel = Vector2()
				break
			
			if c.collider_name == "gate":
				queue_free()
				break

			# print(norm)
			#if vel.length() > 1.0:
			#	var pitch = vel.length()
			#	if sound == "bell":
			#		pass
			#	else:
			#		pitch *= 2
				
				#pitch = notes[round(pitch)] #pow(2, round(log(pitch) / log(2)) / 3.0)
				#pitch *= round(rand_range(1,7))
				#pitch += rand_range(-1,1)*0.002
				#AudioPlayer.play_at(sound, position, pitch)
		
			if vel.dot(norm) > 0:
				norm = -norm
			var restitution = 0.8
			vel = (-vel.reflect(norm)).linear_interpolate(vel.slide(norm), 1-restitution)
			position = coll + norm * 0.1
			
			var shockwave = preload("res://shockwave.tscn").instance()
			shockwave.position = position
			#shockwave.modulate = $spr.modulate
			get_parent().add_child(shockwave)
			AudioPlayer.play_at("bell", position, 1)
	

#	var colliders_mars = get_tree().get_nodes_in_group("mars")
#	for m in colliders_mars:
#		var collision_info = move_and_collide(vel * delta)
#		if collision_info:
#			var collision_point = collision_info.collider.name
#			print(String(collision_point))
#			#collision then reset the postion
#			if collision_point == "rock":
#				#position.y = 1001
#				position = initalpos
#				vel = Vector2()
