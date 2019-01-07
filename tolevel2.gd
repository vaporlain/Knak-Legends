extends Node2D

#next level script!
#foreach level the name of the next one is different
export(String, FILE, "*.tscn") var worldscene

# save to this location
const SAVE_PATH = "user://save.json"

func _on_Area2D_body_entered(body):
	if body.name == "player":
			get_tree().change_scene(worldscene)
			save_game() #Eerst veranderen van scene en dan niet bestaande functie aanroepen???
			
# functie voor maken van dictionary
func save():
	# create dictionary for json
	var save_dict = {
		"level" : worldscene
		}
	return save_dict
	
func save_game():
	# get all data to save from persistent nodes
	var save_dict = {}
	var toSave = get_tree().get_nodes_in_group("Persistent")
	for node in toSave:
		save_dict[node.get_path()]= node.save()
	
	# create savefile
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(save_dict))
	save_file.close()