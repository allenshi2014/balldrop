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

	
	$earth.rotation_degrees += 0.05
	$earth2.rotation_degrees += 0.05


func _on_Button_pressed():
	get_tree().change_scene("res://main.tscn")
	#push_warning(String(new_scene))


func _on_TouchScreenButton_released():
	$earth2.scale = 1.5
	push_warning("button released.")
	push_error("button released!!!")


func _on_TouchScreenButton_pressed():
	$earth2.scale = 1.5
	$earth.rotation_degrees += 1
	$earth2.rotation_degrees += 1
	push_warning("button released.")
	push_error("button released!!!")
