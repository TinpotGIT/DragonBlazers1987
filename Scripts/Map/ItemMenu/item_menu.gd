extends Control

var totalPages
var currentPage = 0

func pageUpdater():
	totalPages = int(len(GlobalVariables.global_item_inventory)/12)

func updateInfoItem():
	for i in range(0, 12):
		if i < len(GlobalVariables.global_item_inventory) - (11*currentPage):
			var item_scene = load("res://Scenes/Objects/item.tscn")
			var item = item_scene.instantiate()
			add_child(item)
			if i%2 == 0:
				item.position = Vector2(11, 28 + (20 * int(i/2)))
			else:
				item.position = Vector2(137, 28 + (20 * int(i/2)))
			item.get_child(0).text = str($BackgroundObjetsMagies.nonEquipmentItems[GlobalVariables.global_item_inventory[(11*currentPage)+i]][0])
			item.get_child(0).focus_entered.connect(_on_button_focus_entered.bind(item.get_path(), (11*currentPage)+i))
			if i == 0:
				item.grab_focus()
		updateFocus()

func updateFocus():
	var maxI = len(GlobalVariables.global_item_inventory) - (12*currentPage)
	for i in range (0, 12):
		if i < maxI:
			if i%2 == 0:
				get_child(i+5).get_child(0).focus_neighbor_right = get_child(i+6).get_child(0)
			else:
				get_child(i+5).get_child(0).focus_neighbor_left = get_child(i+4).get_child(0)
			if i != 0 and i != 1:
				get_child(i+5).get_child(0).focus_neighbor_top = get_child(i+3).get_child(0)
			if i != maxI - 1 and i != maxI:
				get_child(i+5).get_child(0).focus_neighbor_bottom = get_child(i+7).get_child(0)

func _on_button_focus_entered(extra_arg_0: NodePath, id: int) -> void:
	$HandCursor.global_position = Vector2(get_node(extra_arg_0).global_position.x - 3, get_node(extra_arg_0).global_position.y + 10)
	if len(GlobalVariables.global_item_inventory) > id:
		$Description.text = str($BackgroundObjetsMagies.nonEquipmentItems[GlobalVariables.global_item_inventory[id]][1])
