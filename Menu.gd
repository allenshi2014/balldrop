extends Node2D

func _process(_delta):
	
	#$bg.scale += Vector2(0.0001, 0.0001)
	#$bg.position += Vector2(-0.01, 0)
	#$earth.position += Vector2(0.05, 0)
	#$earth.scale += Vector2(0.0001, 0.0001)
	$earth.rotation_degrees += 0.05
	var earth_degree = $earth.get_rotation_degrees()
	if  earth_degree > 4 and earth_degree < 5:
		$comet.set_emitting(true)
	else:
		$comet.set_emitting(false)
		

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://level/stage1/stage1_1.tscn")
