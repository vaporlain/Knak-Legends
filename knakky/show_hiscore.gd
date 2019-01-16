extends Label

# hier wil ik alle highscores laten zien door alle save files één voor één te openen en de "total_score" value appenden naar de array hieronder
# deze array word dan in de label geprint
# wat er wel lelijk uit ziet is hoe het geprint word in de label

var hiscores = []

func _ready():	
	get_score()
	self.text = str(hiscores)

	
func get_score():
	var f = File.new()
	for i in range(50):
		if f.file_exists("user://" + str(i) + ".json"):
			f.open("user://" + str(i) + ".json", File.READ)
			var data = parse_json(f.get_as_text())
	
			for node_path in data.keys():
				var node = get_node(node_path)
				for attribute in data[node_path]:
					if attribute == "total_score":
						hiscores.append(data[node_path]['total_score'])