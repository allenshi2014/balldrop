extends Node2D

func _process(_delta):
	
	$earth.rotation_degrees += 0.05
	var earth_degree = $earth.get_rotation_degrees()
	if  earth_degree > 93 and earth_degree < 94:
		$comet.set_emitting(true)
	else:
		$comet.set_emitting(false)
		

func _on_btn_new_pressed():
	get_tree().change_scene("res://level/stage1/stage1_1.tscn")

func _on_btn_setting_pressed():
	get_tree().change_scene("res://selection.tscn")

func _on_btn_option_pressed():
	pass
