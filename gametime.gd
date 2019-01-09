extends Label
var time = 0
var timer
var label
var string1 = "Current score: %d"
var score
signal score_change(score)

func _ready():
	score = 10000
	timer = $Timer
	timer.start()
	

func add_score():
	#print("UI RECIEVED SIGNAL!")
	score+=1000
	self.text = string1 % score

func _on_Timer_timeout():
	time = time + 1
	
	if score > 0:
		score -= 500
	
	self.text = string1 % score
	emit_signal("score_change", score)
	timer.start()

func save():
	global.score.append(score)
	print(global.score)
	
	# create dictionary for json
	var save_dict = {
		"score" : global.score,
		}
	return save_dict