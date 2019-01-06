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
	

func _on_Timer_timeout():
	time = time + 1
	score = score - time * 2
	self.text = string1 % score
	emit_signal("score_change", score)
	timer.start()

