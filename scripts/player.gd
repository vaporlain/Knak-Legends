extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
export (int) var max_speed = 200
export (int) var jump_height = 300
export (int) var friction = 0.2
const ACCELERATION = 50
export (int) var gravity = 10
var gameover = false

func _physics_process(delta):

	if gameover==false:
		
		motion.y += gravity
		
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x+ACCELERATION, max_speed) #kies de laagste, anders speed up
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x-ACCELERATION, -max_speed)
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.play("idle")
			motion.x = lerp(motion.x, 0, friction)
	
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -jump_height
			
		else:
			$AnimatedSprite.play("jump")
		
		motion = move_and_slide(motion, UP)
		
	pass
