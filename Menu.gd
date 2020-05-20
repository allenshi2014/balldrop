extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#$bg.scale += Vector2(0.0001, 0.0001)
	#$bg.position += Vector2(-0.01, 0)
	#$earth.position += Vector2(0.05, 0)
	#$earth.scale += Vector2(0.0001, 0.0001)

	
	$earth_menu.rotation_degrees += 0.05


func _on_Button_pressed():
	get_tree().change_scene("res://main.tscn")
	#push_warning(String(new_scene))
