extends Node

var menus = load("res://menu.tscn")
onready var this = get_node(".")

func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0 :
			print("[["+N.get_name()+"]]")
			getallnodes(N)
		else:
			print("-> "+N.get_name())

func _ready():
	#Intro here or menu
	#StartGame()
	#getallnodes(self)
	
	var menu = menus.instance()
	this.call_deferred("add_child", menu)