extends Control

func updateInfoItem():
	for i in range(len(GlobalVariables.global_item_inventory)):
		get_node("ItemSlot"+str(i)).text = str($BackgroundObjetsMagies.nonEquipmentItems[GlobalVariables.global_item_inventory[i]][0])
	$ButtonSlot0.grab_focus.call_deferred()
	
func _on_button_focus_entered(extra_arg_0: NodePath, id: int) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 9, get_node(extra_arg_0).position.y + 10)
	if len(GlobalVariables.global_item_inventory) > id:
		$Description.text = str($BackgroundObjetsMagies.nonEquipmentItems[GlobalVariables.global_item_inventory[id]][1])
