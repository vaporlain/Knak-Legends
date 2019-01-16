extends Node2D

#next level script!
#foreach level the name of the next one is different
export(String, FILE, "*.tscn") var worldscene

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene(worldscene)
		save.write()
			
# functie voor maken van dictionary
func save():
	# create dictionary for json
	var save_dict = {
		"level" : worldscene
		}
	return save_dict