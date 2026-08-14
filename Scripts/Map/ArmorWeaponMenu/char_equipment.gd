extends Control

@export var id = 0

func updateInfo(isArmor : int):
	var charID = GlobalVariables.team_formation[id]
	$CharName.text = GlobalVariables.global_names[charID]
	for i in range(4):
		var Item = "Item"+str(i)
		var itemID = GlobalVariables.global_equipment_inventory[id][isArmor][i]
		var itemsNode = get_parent().get_child(0)
		var isEquipped = GlobalVariables.global_is_equipped[id][isArmor][i]
		print(isEquipped)
		if isEquipped:
			get_node(Item+"/EquipCheck").text = "E-"
		else:
			get_node(Item+"/EquipCheck").text = ""
		get_node(Item+"/ItemName").text = itemsNode.items[itemID][0]
		get_node(Item+"/ItemIcon").texture = load(itemsNode.items[itemID][-1])
