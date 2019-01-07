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
		get_node(bodyname).queue_free()
		emit_signal("add_score")
	else:
		print("Sendt the wrong signal to level")
