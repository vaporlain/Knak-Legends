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
		$AnimatedSprite.play("walkright")
	else:
		$AnimatedSprite.play("idleright")
	pass

func moveright():
	if totheleft == false:
		motion.x = min(motion.x-ACCELERATION, -max_speed)
		$AnimatedSprite.play("walkleft")
	else:
		$AnimatedSprite.play("idleleft")
	pass

func _physics_process(delta):
	motion.y += gravity
	motion = move_and_slide(motion, UP)
	
	pass

func _on_viewright_body_entered(body):
	if totheleft==true && body.name == "player":
		$AnimatedSprite.play("attackleft")
	pass # replace with function body


func _on_viewleft_body_entered(body):
	if totheleft==false && body.name == "player":
		$AnimatedSprite.play("attackright")
	pass # replace with function body
