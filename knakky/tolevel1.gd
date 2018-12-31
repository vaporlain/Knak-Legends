extends Node2D

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	var stage = get_node(".")
	getallnodes(stage)

func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0 :
			print("[["+N.get_name()+"]]")
			getallnodes(N)
		else:
			print("-> "+N.get_name())


func _on_intro_button_up():
	get_tree().change_scene("res://map1.tscn")


func _on_skip_intro_button_up():
	get_tree().change_scene("res://map2.tscn") 


func _on_exit_button_up():
	get_tree().quit()


func _on_back_button_up():
	get_tree().change_scene("res://menu.tscn")


func _on_highscores_button_up():
	get_tree().change_scene("res://highscore.tscn")
