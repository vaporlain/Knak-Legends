extends KinematicBody2D
#======================
#Variable declaration
#Scope: this script
#======================

#easy acces vars
const SPEED = 300
const GRAVITY = 20
const JUMP_H = -500
const MAXJUMPS = 1

#advanced vars
var motion = Vector2(0,0)
const UP = Vector2(0, -1)
var offsetright = Vector2(25,0)
var offsetleft = Vector2(-25, 0)
enum PlayerStates {left, right, idle, attacking = 0}
var dead;
var excecuted = false
var timesjumped = 0
var cankillright = false
var cankillleft = false

#SIGNAL
signal kills

#Updates every stable physics framerate.5
func _physics_process(delta):

	if dead == false:
		
		#apply gravity
		motion.y += GRAVITY
		
		#apply the motion/ movement to the player
		#UP means platformer style
		motion = move_and_slide(motion, UP)
		
	
	pass

func _ready():
	emit_signal("kills")
	dead=false
	pass

func _unhandled_input(event):
	
	if dead == false:
		
		if is_on_floor():
			timesjumped = 0
		
		if event.is_action("ui_left") == true:
			
			if event.is_action_released("ui_left"):
				motion.x = 0
				$AnimatedSprite.offset = offsetleft
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("idle")
				
			else:
				motion.x = (SPEED * -1)
				$AnimatedSprite.offset = offsetleft
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("run")
				
		
		
		if event.is_action("ui_right")==true:
			
			if event.is_action_released("ui_right"):
				motion.x = 0
				$AnimatedSprite.offset = offsetright
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("idle")
				
			else:
				$AnimatedSprite.offset = offsetright
				motion.x = SPEED
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("run")
			
		
		if event.is_action("jump"):
			
			if timesjumped <= MAXJUMPS && event.is_action_pressed("jump"):
				motion.y = JUMP_H
				timesjumped = timesjumped + 1
		
		if event.is_action("attack"):
			
			if event.is_action_pressed("attack"):
				$AnimatedSprite.play("attack")
				PlayerStates.attacking=1
			
		
	
	pass


func _on_player_animation_finished():
	
	if $AnimatedSprite.get_animation() == "attack":
		$AnimatedSprite.play("idle")
		PlayerStates.attacking = 0
	
	if $AnimatedSprite.get_animation() == "die":
		dead = true
		get_tree().change_scene("res://scenes/gameover.tscn")
	


func _on_right_body_entered(body):
	if body.name == "EnemyKB":
#		print("i can kil on my right")
#			something like enemy.state = dead
		if PlayerStates.attacking == 1:
			print("KILLED ON MY RIGHT")



func _on_left_body_entered(body):
	if body.name == "EnemyKB":
#		print("i can kil on my left")
#			something like enemy.state = dead
		if PlayerStates.attacking == 1:
			print("KILLED ON MY LEFT")




func _on_hitbox_body_entered(body):
	if body.name == "EnemyKB" || body.name == "spikes" :
		dead = true
		$AnimatedSprite.play("die")
		$AnimatedSprite.offset = Vector2(0,10)
		$AnimatedSprite.scale = Vector2(3,3)
		print("OUCH!")
	pass # replace with function body
