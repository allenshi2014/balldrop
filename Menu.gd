extends Node2D

func _process(_delta):
	
	#$bg.scale += Vector2(0.0001, 0.0001)
	#$bg.position += Vector2(-0.01, 0)
	#$earth.position += Vector2(0.05, 0)
	#$earth.scale += Vector2(0.0001, 0.0001)
	$earth.rotation_degrees += 0.05

func _on_Button_pressed():
	get_tree().change_scene("res://level/stage1/stage1_1.tscn")
