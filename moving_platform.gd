extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar
var xSpeed = 0
var ySpeed = -50
var speed = Vector2(xSpeed,ySpeed)

const UP = Vector2(0,-1)

func _ready():
	
	pass



func _physics_process(delta):
	move_platform(speed, 0, 50)
	pass


func move_platform(speed, maxX, maxY):
	move_and_slide(speed, UP)
	
	pass