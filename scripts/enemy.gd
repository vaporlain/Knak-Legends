extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
export (int) var max_speed = 200
export (int) var jump_height = 300
export (int) var friction = 0.2
const ACCELERATION = 50
export (int) var gravity = 10
var timer

func _ready():
	
	timer = Timer.new()
	timer.connect("timeout",self, "tick")
	add_child(timer)
	timer.wait_time=1.0
	timer.start()
	
	pass

func tick():
	print("TICKED")
	pass

func moveleft():
	motion.x = max(motion.x-ACCELERATION, -max_speed)
	$AnimatedSprite.play("hover")
	$AnimatedSprite.flip_h = true
	pass

func moveright():
	motion.x = min(motion.x-ACCELERATION, max_speed)
	$AnimatedSprite.play("hover")
	$AnimatedSprite.flip_h = false
	pass

func _physics_process(delta):
	
	motion.y += gravity
	
	if is_on_floor():
		$AnimatedSprite.play("idle")
	
	else:
		$AnimatedSprite.play("hover")
	
	motion = move_and_slide(motion, UP)
	
	pass
