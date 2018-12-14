extends Area2D

signal killem

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "player":
		emit_signal("killem")
	pass # replace with function body
