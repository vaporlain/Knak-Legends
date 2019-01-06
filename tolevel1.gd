extends Node2D

# set save path only allows for 1 save file at the moment
const SAVE_PATH = "user://save.json"

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	pass

func _on_startbutton_pressed():
	get_tree().change_scene("res://map1.tscn") 
	pass

func _on_exit_button_up():
	get_tree().quit()

func _on_continue_pressed():
	# load game when button is pressed
	# code could be made prettier by putting it somewhere else, but this works
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