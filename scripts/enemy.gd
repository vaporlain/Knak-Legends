extends KinematicBody2D

var motion = Vector2()
var totheleft = true
const UP = Vector2(0, -1)
export (int) var max_speed = 200
export (int) var friction = 0.2
const ACCELERATION = 50
export (int) var gravity = 10
export var patroldistance = 0.5
var timer

func _ready():
	
	timer = Timer.new()
	timer.connect("timeout",self, "tick")
	add_child(timer)
	timer.wait_time=patroldistance
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

func _physics_process(delta):
	motion.y += gravity
	motion = move_and_slide(motion, UP)
	
	pass