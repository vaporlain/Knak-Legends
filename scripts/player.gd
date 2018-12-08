extends KinematicBody2D
#======================
#Variable declaration
#Scope: this script
#======================

#easy acces vars
const SPEED = 300
const GRAVITY = 10
const JUMP_H = -400
const MAXJUMPS = 2

#advanced vars
var motion = Vector2(0,0)
const UP = Vector2(0, -1)
var offsetright = Vector2(25,0)
var offsetleft = Vector2(-25, 0)
enum PlayerStates {left, right, idle, attacking = 0, dead}
var excecuted = false
var timesjumped = 0

#If the players HITbox gets HIT
func _on_hitbox_body_entered(body):
	if body.name == "EnemyKB" :
		print("U just got killed by:" + body.name)
		get_tree().change_scene("res://scenes/gameover.tscn")
	pass 

#Updates every stable physics framerate.
func _physics_process(delta):
	#apply gravity, always
	motion.y += GRAVITY

	#apply the motion/ movement to the player
	#UP means platformer style
	motion = move_and_slide(motion, UP)
	
	pass



func _unhandled_input(event):
	
	if is_on_floor():
		timesjumped = 0
	
	if event.is_action("ui_left") == true:
		
		if event.is_action_pressed("ui_left"):
			print("go left")
			motion.x = (SPEED * -1)
			$AnimatedSprite.offset = offsetleft
			$AnimatedSprite.flip_h=true
			$AnimatedSprite.play("run")
		
		elif event.is_action_released("ui_left"):
			print("stop left")
			motion.x = 0
			$AnimatedSprite.offset = offsetleft
			$AnimatedSprite.flip_h=true
			$AnimatedSprite.play("idle")

	
	if event.is_action("ui_right")==true:
		
		if event.is_action_pressed("ui_right"):
				print("go right")
				$AnimatedSprite.offset = offsetright
				motion.x = SPEED
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("run")
		
		elif event.is_action_released("ui_right"):
			print("stop right")
			motion.x = 0
			$AnimatedSprite.offset = offsetright
			$AnimatedSprite.flip_h=false
			$AnimatedSprite.play("idle")
		
	
	if event.is_action("jump"):
		if timesjumped <= MAXJUMPS && event.is_action_pressed("jump"):
			motion.y = JUMP_H
			timesjumped = timesjumped + 1
	
	if event.is_action("attack"):
		
		if event.is_action_pressed("attack"):
			$AnimatedSprite.play("attack")
			PlayerStates.attacking=1
		
	
	pass

#func _on_rightattack_body_entered(body):
#	if body.name == "enemyKB":
#		print("I can kill on my right "+body.name)
#	pass # replace with function body


func _on_player_animation_finished():
	if $AnimatedSprite.get_animation() == "attack":
		$AnimatedSprite.play("idle")
		PlayerStates.attacking = 0
	pass # replace with function body


func _on_right_body_entered(body):
	if body.name == "EnemyKB":
#		print("i can kil on my right")
		if PlayerStates.attacking == 1:
			print("KILLED ON MY RIGHT")
#			something like enemy.state = dead
	pass # replace with function body


func _on_left_body_entered(body):
	if body.name == "EnemyKB":
#		print("i can kil on my left")
		if PlayerStates.attacking == 1:
			print("KILLED ON MY LEFT")
#			something like enemy.state = dead
	pass # replace with function body
