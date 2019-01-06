extends Control

func _ready():
	pass


func _on_mainmenu_button_up():
	get_tree().change_scene("res://scenes/menu.tscn")
	pass # replace with function body


func _on_exit_button_up():
	get_tree().quit()
	pass # replace with function body
