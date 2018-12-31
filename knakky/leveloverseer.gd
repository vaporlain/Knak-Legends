extends Node
#This script's function is getting signals sendt by for example 'playerroot',
#And makes it possible to have export variables in levels, and killing/ dying of the player.
#WIP

func _ready():
	print("## NODES IN SCENE: ##")
	#getallnodes(self)
	print("###")

func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0 :
			print("[["+N.get_name()+"]]")
			getallnodes(N)
		else:
			print("-> "+N.get_name())

func _on_player_hits(bodyname):
	print("SIGNAL RECIEVED FROM PLAYER")
	get_node(bodyname).queue_free()
