extends KinematicBody2D

var motion = Vector2()
var totheleft = true
const UP = Vector2(0, -1)
var max_speed = 50
var gravity = 10
var patroldistance = 2
var timer

func _ready():
	
	#random number from 1 to 2
	var randir = randi()%3+1
	print(randir)
	
	if randir == 1:
		totheleft = true
	else:
		totheleft = false
	
	timer = Timer.new()
	timer.connect("timeout",self, "tick")
	add_child(timer)
	timer.wait_time = patroldistance
	timer.start()
	
	tick()
	pass

func tick():
	if totheleft == true:
		moveleft()
		totheleft = false
	elif totheleft == false:
		moveright()
		totheleft = true
	pass

func moveleft():
	if totheleft == true:
		motion.x = max_speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
	pass

func moveright():
	if totheleft == false:
		motion.x = -max_speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
	pass

func bekilled():
	self.free()
	pass

#The most advanced in-built function
#Updates every stable physics framerate.
func _physics_process(delta):
	#apply gravity, always
	motion.y += gravity
	
	#apply the motion/ movement to the player
	#UP means platformer style
	motion = move_and_slide(motion, UP)
	
	pass
