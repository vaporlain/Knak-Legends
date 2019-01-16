extends Node2D

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	var stage = get_node(".")
	getallnodes(stage)

func getallnodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0 :
			print("[["+N.get_name()+"]]")
			getallnodes(N)
		else:
			print("-> "+N.get_name())

func _on_continue_pressed():
	# load game when button is pressed
	var save_file = File.new()
	if not save_file.file_exists(save.path):
		return
		
	save_file.open(save.path, File.READ)
	var data = parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "level":
				get_tree().change_scene(data[node_path]['level'])


func _on_intro_button_up():
	get_tree().change_scene("res://credits.tscn")

# uitleg over hoe ik moet uitleggen aangezien ik sochtens harstikke gaar zal zijn:
# voor elke nieuwe game word een aparte save file gemaakt
# elke save file krijgt een id in de filename, deze word bepaald door in de save folder te controleren welke id's al aanwezig zijn
# zoals in de for loop te zien is, is er plaats voor maximaal 50 save files. Zodra het spel geen nieuwe files kan vinden, word de ID op dat nummer gezet en stopt de loop
# alle scores van voorgaande games worden meteen gereset tijdens deze handeling om fouten te voorkomen
# ben ervan op de hoogte dat alles in 1 save file opgeslagen kan worden door data te nesten maar ik ga slapen
func _on_skip_intro_button_up():
	get_tree().change_scene("res://map1.tscn")
	var f = File.new()
	for i in range(50):
		if not f.file_exists("user://" + str(i) + ".json"):
			save.path = "user://" + str(i) + ".json"
			global.score = []
			global.totalScore = 0
			return

func _on_exit_button_up():
	get_tree().quit()


func _on_back_button_up():
	get_tree().change_scene("res://menu.tscn")


func _on_highscores_button_up():
	get_tree().change_scene("res://highscore.tscn")