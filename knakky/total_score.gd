extends Label

# save functie MOET voor _ready komen, anders word total_score niet opgeslagen

func save():
	for i in global.score:
		global.totalScore = global.totalScore + i
		print(global.totalScore)
	# create dictionary for json
	var save_dict = {
		"total_score" : global.totalScore,
		"score" : global.score
		}
	return save_dict

func _ready():
	save.write()
	self.text = "Your score is: " + str(global.totalScore)