extends Node2D

#next level script!
#foreach level the name of the next one is different

export(String, FILE, "*.tscn") var worldscene

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.name == "player":
			get_tree().change_scene(worldscene)
	pass # replace with function body
