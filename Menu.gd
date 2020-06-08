extends Node2D

func _process(_delta):
	
	$earth.rotation_degrees += 0.05
	var earth_degree = $earth.get_rotation_degrees()
	if fmod(earth_degree, 50) >= 0 and fmod(earth_degree, 50) < 1:
		$comet.set_emitting(true)
	else:
		$comet.set_emitting(false)


func _on_btn_play_pressed():
	get_tree().change_scene("res://selection.tscn")
