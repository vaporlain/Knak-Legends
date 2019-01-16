extends Node

var id = 0

# save to "Roaming/Godot/app_userdata/knakky"
var path = "user://" + str(id) + ".json"

func _ready():
	pass

# dit is een global save functie dat aangeroepen kan worden vanuit alle andere functies
func write():
	# get all data to save from persistent nodes
	var save_dict = {}
	var toSave = get_tree().get_nodes_in_group("Persistent")
	for node in toSave:
		save_dict[node.get_path()]= node.save()
	
	# create savefile
	var save_file = File.new()
	save_file.open(save.path, File.WRITE)
	
	save_file.store_line(to_json(save_dict))
	save_file.close()