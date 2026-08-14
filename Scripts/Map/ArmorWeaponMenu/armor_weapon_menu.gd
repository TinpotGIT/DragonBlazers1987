extends Control

var isArmor = 0
var swapID = -1
var swapChar = -1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"): 
		escapePressed()

func escapePressed():
	var actionList = get_parent().get_parent().actionList
	if len(actionList) != 0:
		match actionList[len(actionList) - 1]:
			"ArmorWeapon":
				popActionList()
				visible = false
				get_node("../MapMenu").visible = true
			"Equipping":
				popActionList()
				$EquipButton.grab_focus()
			"Throwing":
				popActionList()
				$ThrowButton.grab_focus()
			"SwapReady":
				popActionList()
			"Swapping":
				popActionList()
				$SwapButton.grab_focus()
		

func updateArmorWeaponMenu(ArmorCheck : int):
	isArmor = ArmorCheck
	changeMenuName()
	$Char0.updateInfo(isArmor)
	$Char1.updateInfo(isArmor)
	$Char2.updateInfo(isArmor)
	$Char3.updateInfo(isArmor)
	$EquipButton.grab_focus.call_deferred()

func appendActionList(action : String):
	get_parent().get_parent().actionList.append(action)
	
func popActionList():
	get_parent().get_parent().actionList.pop_back()

func getActionList():
	return get_parent().get_parent().actionList

func changeMenuName():
	match isArmor:
		0:
			$MenuName.text = "ARMES"
		1:
			$MenuName.text = "ARMURES"

func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.global_position = Vector2(get_node(extra_arg_0).global_position.x - 9, get_node(extra_arg_0).global_position.y + 10)

func _on_equip_button_pressed():
	$Char0/Item0/ItemSelect.grab_focus()
	appendActionList("Equipping")

func _on_swap_button_pressed():
	$Char0/Item0/ItemSelect.grab_focus()
	appendActionList("Swapping")

func _on_throw_button_pressed():
	$Char0/Item0/ItemSelect.grab_focus()
	appendActionList("Throwing")

func _on_item_select_pressed(equipID : int, charID : int):
	var actionList = getActionList()
	match actionList[len(actionList) - 1]:
		"Equipping":
			equipItem(equipID, charID)
		"Swapping":
			chooseFirstSwap(equipID, charID)
		"SwapReady":
			chooseSecondSwap(equipID, charID)
		"Throwing":
			throwItem(equipID, charID)

func equipItem(equipID : int, charID : int):
	var itemID = GlobalVariables.global_equipment_inventory[charID][isArmor][equipID]
	var isEquipped = GlobalVariables.global_is_equipped[charID][isArmor][equipID]
	if isEquipped:
		GlobalVariables.global_is_equipped[charID][isArmor][equipID] = false
	else:
		checkEquipped(equipID, charID)
	get_node("Char"+str(charID)).updateInfo(isArmor)

func checkEquipped(equipID: int, charID : int):
	var itemInventory = GlobalVariables.global_equipment_inventory[charID][isArmor]
	var equipInventory = GlobalVariables.global_is_equipped[charID][isArmor]
	var switched = false

	for i in range(4):
		var equipment = itemInventory[i]
		var isEquipped = equipInventory[i]
		if isEquipped:
			if (isArmor == 0) or (isSameArmorType(equipment, itemInventory[equipID])):
				GlobalVariables.global_is_equipped[charID][isArmor][equipID] = true
				GlobalVariables.global_is_equipped[charID][isArmor][i] = false
				print("Found same type")
				switched = true
				break
	
	if switched == false:
		GlobalVariables.global_is_equipped[charID][isArmor][equipID] = true

func isSameArmorType(currentEquipment, chosenEquipment):
	var currentEquipmentType = getArmorType(currentEquipment)
	var chosenEquipmentType = getArmorType(chosenEquipment)
	return currentEquipmentType == chosenEquipmentType

func getArmorType(equipment):
	if equipment >= 42 and equipment <= 53:
		return "Armor"
	elif equipment >= 54 and equipment <= 65:
		return "Armlet"
	elif equipment >= 66 and equipment <= 74:
		return "Shield"
	elif equipment >= 75 and equipment <= 81:
		return "Helmet"
	
func chooseFirstSwap(equipID : int, charID : int):
	swapID = equipID
	swapChar = charID
	appendActionList("SwapReady")

func chooseSecondSwap(equipID : int, charID : int):
	var storedItemID = GlobalVariables.global_equipment_inventory[swapChar][isArmor][swapID]
	GlobalVariables.global_equipment_inventory[swapChar][isArmor][swapID] = GlobalVariables.global_equipment_inventory[charID][isArmor][equipID]
	GlobalVariables.global_is_equipped[swapChar][isArmor][swapID] = GlobalVariables.global_is_equipped[charID][isArmor][equipID]
	GlobalVariables.global_equipment_inventory[charID][isArmor][equipID] = storedItemID
	GlobalVariables.global_is_equipped[swapChar][isArmor][swapID] = false
	GlobalVariables.global_is_equipped[charID][isArmor][equipID] = false
	get_node("Char"+str(swapChar)).updateInfo(isArmor)
	get_node("Char"+str(charID)).updateInfo(isArmor)
	popActionList()
		
func throwItem(equipID : int, charID : int):
	GlobalVariables.global_equipment_inventory[charID][isArmor][equipID] = 0
	GlobalVariables.global_is_equipped[charID][isArmor][equipID] = false
	get_node("Char"+str(charID)).updateInfo(isArmor)
	
func goBack():
	var actionList = getActionList()
	actionList.pop_back()
	if len(actionList) == 0:
		$EquipButton.grab_focus()
	else:
		match actionList[len(actionList)-1]:
			"Equipping":
				$EquipButton.grab_focus()
			"Swapping":
				$EquipButton.grab_focus()
			"Throwing":
				$EquipButton.grab_focus()
