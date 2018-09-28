extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var dirr = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	#this is like a switch satement! and again.. it just works
	match dirr:
		0:
			print("staat stil")
		1:
			self.position.x -= 5
		2:
			self.position.x += 5
		3:
			self.position.y -= 5
		4:
			self.position.y += 5
	
	match Input.is_action_just_pressed(x):
		"move_left":
			dirr=1
		"move_right":
			dirr=2
		"move_up":
			dirr=3
		"move_down":
			dirr=4
	pass
