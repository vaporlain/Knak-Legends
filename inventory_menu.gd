extends Node

onready var itemList = get_node("Panel/ItemList")

const item = preload("res://item.tscn")
var id
var itemEnt

func _ready():
	print("initialize")
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(48, 48))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
	for i in range(1, 40):
		var icon
		if i < 10:
			icon = ResourceLoader.load("res://textures/items/genericItem_color_00" + String(i) + ".png")
			itemList.add_item("", icon, true)
			continue
		if i < 40:
			icon = ResourceLoader.load("res://textures/items/genericItem_color_0" + String(i) + ".png")
			itemList.add_item("", icon, true)
			continue
		icon = ResourceLoader.load("res://textures/items/genericItem_color_" + String(i) + ".png")
		itemList.add_item("", icon, true)	

func _on_ItemList_item_selected(index):
	print(index)

func _on_ItemList_item_rmb_selected(index, at_position):
	print(index)
	itemList.remove_item(index)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_I:
			self.visible = true
	
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_Q:
			itemEnt = item.instance()
			var pos = Vector2()
			id = 1
			idLoader()
			pos.x = rand_range(-560, 80)
			pos.y = 0
			itemEnt.position = pos
			get_node(".").add_child(itemEnt)
		elif event.pressed and event.scancode == KEY_W:
			itemEnt = item.instance()
			var pos = Vector2()
			id = 2
			idLoader()
			pos.x = rand_range(-560, 80)
			pos.y = 0
			itemEnt.position = pos
			get_node(".").add_child(itemEnt)


func idLoader():
	if id == 1:
		itemEnt.modulate = Color(100, 0, 0, 255)
	elif id == 2:
		itemEnt.modulate = Color(0, 0, 100, 255)