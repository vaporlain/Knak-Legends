extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
export (int) var speed = 100
export (int) var jump_height = 400
export (int) var gravity = 10
var gameover = false

func _physics_process(delta):

	if gameover==false:
		motion.y += gravity
		
		if Input.is_action_pressed("ui_right"):
			motion.x = speed
		elif Input.is_action_pressed("ui_left"):
			motion.x = -speed
		else:
			motion.x = 0
	
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -jump_height
				
		motion = move_and_slide(motion, UP)
	pass
