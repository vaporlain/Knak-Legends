extends KinematicBody2D
#======================
#Variable declaration
#Scope: this script
#======================

#easy acces vars
const MAX_SPEED = 300
const FRICTION = 0.2
const ACCELERATION = 50
const GRAVITY = 10
const JUMP_H = -400

#advanced vars
var motion = Vector2(0,0)
const UP = Vector2(0, -1)
var attacking = false
var offsetright = Vector2(25,0)
var offsetleft = Vector2(-25, 0)


#======================
#My Functions:
#======================

func get_input():
	
	#Input for moving to the left or right
	if Input.is_action_pressed("attack"):
		attacking=true
		attack()
	
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite.offset = offsetright
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.offset = offsetleft
		$AnimatedSprite.flip_h=true
		$AnimatedSprite.play("run")
	else:
		motion.x=0
		$AnimatedSprite.play("idle")
	
	#input for jumping
	if is_on_floor():
		if Input.is_action_pressed("ui_up") || Input.is_action_pressed("jump"):
			motion.y = JUMP_H
	

	
	pass

func attack():
	if(attacking==true):
		$AnimatedSprite.play("attack")
	else:
		$AnimatedSprite.play("idle")
	pass

#If the players HITbox gets HIT
func _on_hitbox_body_entered(body):
	if body.name == "EnemyKB" :
		print("U just got killed by:" + body.name)
		get_tree().change_scene("res://scenes/gameover.tscn")
	pass 

#======================
#Built-in functions
#Scope: this script
#======================

func _ready():
	#player is loaded
	
	pass

#Updates every stable physics framerate.
func _physics_process(delta):
	#apply gravity, always
	motion.y += GRAVITY
	
	get_input();
	
	#apply the motion/ movement to the player
	#UP means platformer style
	motion = move_and_slide(motion, UP)
	
	pass

func _on_leftattack2_body_entered(body):
	if body.name == "enemyKB":
		print("I can kill on my left"+body.name)
	pass # replace with function body


func _on_rightattack_body_entered(body):
	if body.name == "enemyKB":
		print("I can kill on my right "+body.name)
	pass # replace with function body


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.is_playing("attack"):
		$AnimatedSprite.play("idle")
	pass # replace with function body
