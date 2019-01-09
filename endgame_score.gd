extends Node

const SAVE_PATH = "user://save.json"

func _ready():
	for i in global.score:
		global.totalScore = global.totalScore + i
		print(global.totalScore)
	
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
		
	save_file.open(SAVE_PATH, File.READ)
	var data = parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "score":
				self.text = "Your score is: " + str(global.totalScore)
				
func save():
	var save_dict = {
	"totalScore" : global.totalScore,
	}
	return save_dict