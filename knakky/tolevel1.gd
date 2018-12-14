extends Node2D

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	pass

func _on_startbutton_pressed():
	get_tree().change_scene("res://map1.tscn") 
	pass

func _on_exit_button_up():
	get_tree().quit()
	pass # replace with function body
