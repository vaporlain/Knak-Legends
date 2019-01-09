extends Node2D

# save to this location
const SAVE_PATH = "user://save.json"

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

func _on_continue_pressed():
	# load game when button is pressed
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
		
	save_file.open(SAVE_PATH, File.READ)
	var data = parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "level":
				get_tree().change_scene(data[node_path]['level'])


func _on_intro_button_up():
	get_tree().change_scene("res://credits.tscn")


func _on_skip_intro_button_up():
	get_tree().change_scene("res://map1.tscn") 


func _on_exit_button_up():
	get_tree().quit()


func _on_back_button_up():
	get_tree().change_scene("res://menu.tscn")


func _on_highscores_button_up():
	get_tree().change_scene("res://highscore.tscn")
