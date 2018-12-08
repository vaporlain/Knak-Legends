extends KinematicBody2D

var motion = Vector2()
var totheleft = true
const UP = Vector2(0, -1)
var max_speed = 50
var gravity = 10
var patroldistance = 3
var timer
var offsetright = Vector2(10,0)
var offsetleft = Vector2(-10,0)

# 0 = false and 1 = true
enum WizardStates {left = 0 , right = 0, idle = 0, attacking = 0, dead = 0} 

func _ready():
	
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
		$AnimatedSprite.play("walkright")
		$AnimatedSprite.offset = offsetright
	else:
		$AnimatedSprite.play("idleright")
	pass

func moveright():
	if totheleft == false:
		motion.x = -max_speed
		$AnimatedSprite.play("walkleft")
		$AnimatedSprite.offset = offsetleft
	else:
		$AnimatedSprite.play("idleleft")
	pass

func _physics_process(delta):
	motion.y += gravity
	motion = move_and_slide(motion, UP)
	
	pass

func _on_viewright_body_entered(body):
	if WizardStates.right == 1 && body.name == "player":
		$AnimatedSprite.play("attackleft")
	pass


func _on_viewleft_body_entered(body):
	if WizardStates.left == 1 && body.name == "player":
		$AnimatedSprite.play("attackright")
	pass 


func _on_Wizard_animation_finished():
	#if animation attacking completed, now idle!
	if $AnimatedSprite.get_animation() == "attackright" || $AnimatedSprite.get_animation() == "attackleft":
		WizardStates.attacking = 0
	
	
	elif $AnimatedSprite.get_animation() == "left":
		WizardStates.left = 0
	elif $AnimatedSprite.get_animation() == "right":
		WizardStates.right = 0 

	pass # replace with function body
