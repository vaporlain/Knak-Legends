extends KinematicBody2D

var motion = Vector2()
var totheleft = true
const UP = Vector2(0, -1)
export (int) var max_speed = 100
var friction = 0.2
const ACCELERATION = 50
var gravity = 10
export (float) var patroldistance = 1
var timer

func _ready():
	
	timer = Timer.new()
	timer.connect("timeout",self, "tick")
	add_child(timer)
	timer.wait_time = patroldistance
	timer.start()
	
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
		motion.x = max(motion.x-ACCELERATION, max_speed)
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
	pass

func moveright():
	if totheleft == false:
		motion.x = min(motion.x-ACCELERATION, -max_speed)
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
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
