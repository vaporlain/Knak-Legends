extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var players = load("res://player.tscn")
	var segments = load("res://segment.tscn")
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _on_Node2D_tree_entered():
	pass # replace with function body
