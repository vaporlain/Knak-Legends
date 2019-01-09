extends Node
#This script's function is getting signals sendt by for example 'playerroot',
#And makes it possible to have export variables in levels, and killing/ dying of the player.

signal add_score()
var scorescene

func _ready():
	print("## NODES IN SCENE: ##")
	#getallnodes(self)
	scorescene = get_node("UI/CanvasLayer/UI/Container/score")
	connect("add_score",scorescene, "add_score")


func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0 :
			print("[["+N.get_name()+"]]")
			getallnodes(N)
		else:
			print("-> "+N.get_name())

func _on_player_hits(bodyname):
	#print("DELETING:"+bodyname)
	if "enemy" in bodyname || "coin" in bodyname && bodyname != null:
		get_node(bodyname).set_visible(false)
		
		#set collisions to false!
		get_node(bodyname).set_collision_layer_bit(0, false) #optional
		get_node(bodyname).set_collision_mask_bit(0, false) #optional
		get_node(bodyname).set_collision_layer_bit(1, false) #used by enemy
		get_node(bodyname).set_collision_mask_bit(1, false) # used by enemy
		get_node(bodyname).set_collision_layer_bit(2, false) #used by coin
		get_node(bodyname).set_collision_mask_bit(2, false) #used by coin
		emit_signal("add_score")
	else:
		print("Sendt the wrong signal to level")
