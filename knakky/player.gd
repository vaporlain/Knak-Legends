extends Node2D
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
var attacking
var dead
var movingleft
var movingright
var excecuted = false
var timesjumped = 0
var cankillright = false
var cankillleft = false
var enemyspotted_right = false
var enemyspotted_left = false
var colliding_body = null

#SIGNAL
signal hits(bodyname)
signal gets_hit()

#Updates every stable physics framerate.5
func _physics_process(delta):
	
	#apply gravity
	motion.y += GRAVITY
	
	if movingright == true:
		motion.x = SPEED
	
	if movingleft == true:
		motion.x = -SPEED
	
	if dead == false:
		#apply the motion/ movement to the player
		#UP means platformer style
		motion = move_and_slide(motion, UP)
	
	if enemyspotted_right == true && attacking == true:
		#print("SIGNAL SENDT FROM PLAYER")
		emit_signal("hits", colliding_body)
		attacking = false
		enemyspotted_left = false
		
	if enemyspotted_left == true && attacking == true:
		#print("SIGNAL SENDT FROM PLAYER")
		emit_signal("hits", colliding_body)
		attacking = false
		enemyspotted_left = false
	

func _ready():
	dead=false
	movingright = false
	attacking = false

func _unhandled_input(event):
	
	if dead == false:
		
		#attacking = false
		
		if is_on_floor():
			timesjumped = 0
		
		if event.is_action("ui_left") == true:
			
			if event.is_action_pressed("ui_left"):
				movingleft = true
				motion.x = (SPEED * -1)
				$AnimatedSprite.offset = offsetleft
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("run")
			
			elif event.is_action_released("ui_left"):
				movingleft = false
				motion.x = 0
				$AnimatedSprite.offset = offsetleft
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("idle")
			
		
		if event.is_action("ui_right")==true:
			
			if event.is_action_pressed("ui_right"):
				movingright = true
				$AnimatedSprite.offset = offsetright
				motion.x = SPEED
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("run")
				
			
			elif event.is_action_released("ui_right"):
				movingright = false
				motion.x = 0
				$AnimatedSprite.offset = offsetright
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("idle")
		
		if event.is_action("jump"):
			
			if movingright == true:
				motion.x = SPEED
			
			if movingleft == true:
				motion.x = -SPEED
			
			if timesjumped <= MAXJUMPS && event.is_action_pressed("jump"):
				motion.y = JUMP_H
				timesjumped = timesjumped + 1
			
		
		if event.is_action("attack"):
			$AnimatedSprite.play("attack")
			attacking = true


func _on_player_animation_finished():
	
	if $AnimatedSprite.get_animation() == "attack":
		attacking = false
		$AnimatedSprite.play("idle")
	
	if $AnimatedSprite.get_animation() == "die":
		dead = true
		#get_tree().change_scene("res://scenes/gameover.tscn")
		#var thisscene = get_tree().get_current_scene()
		#get_tree().change_scene(thisscene)
		#get_tree().set_current_scene(thisscene)
		get_tree().reload_current_scene()

func _on_right_body_entered(body):
	if "enemy" in body.name:
		enemyspotted_right=true
		colliding_body = body.name


func _on_left_body_entered(body):
	if "enemy" in body.name:
		enemyspotted_left = true
		colliding_body = body.name



func _on_hitbox_body_entered(body):
	if "enemy" in body.name || "spikes" in body.name :
		dead = true
		$AnimatedSprite.play("die")
		$AnimatedSprite.offset = Vector2(0,10)
		$AnimatedSprite.scale = Vector2(3,3)
		print("OUCH!")


func _on_right_body_exited(body):
	if "enemy" in body.name || "spikes" in body.name :
		enemyspotted_right = false

func _on_left_body_exited(body):
	if "enemy" in body.name || "spikes" in body.name :
		enemyspotted_left = false
