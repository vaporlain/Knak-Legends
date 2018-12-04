extends Node2D

#next level script!
#foreach level the name of the next one is different

export(String, FILE, "*.tscn") var worldscene

func _ready():
	pass

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body.name)
		if body.name == "player":
			get_tree().change_scene(worldscene)
	pass