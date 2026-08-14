extends Node2D

var actionList = []
var storedID = -1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"): 
		escapePressed()

func escapePressed():
	if len(actionList) != 0 and actionList[len(actionList) - 1] == "FormationSwap":
		actionList.pop_back()
	else:
		match len(actionList):
			0:
				actionList.append("EnteredMapMenu")
				$CharacterBody2D/MapMenu.visible = true
				$CharacterBody2D/MapMenu/Items_Button.grab_focus.call_deferred()
				showAllCharInfo()
			1:
				actionList.pop_back()
				$CharacterBody2D/MapMenu.visible = false
			2:
				actionList.pop_back()
				hideMenus()
				$CharacterBody2D/MapMenu.visible = true
				$CharacterBody2D/MapMenu/Items_Button.grab_focus.call_deferred()

func hideMenus():
	$CharacterBody2D/StatMenu.visible = false
	$CharacterBody2D/ItemMenu.visible = false
	$CharacterBody2D/MagicMenu.visible = false
	$CharacterBody2D/ArmorWeaponMenu.visible = false

func showAllCharInfo():
	$CharacterBody2D/MapMenu/CharSlot0.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot1.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot2.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot3.showCharInfo()

func checkChosen(id):
	match actionList[len(actionList) - 1]:
		"Status":
			$CharacterBody2D/StatMenu.visible = true
			$CharacterBody2D/StatMenu.getId(id)
			$CharacterBody2D/StatMenu.updateInformation()
			$CharacterBody2D/MapMenu.visible = false
		"Magic":
			$CharacterBody2D/MagicMenu.visible = true
			$CharacterBody2D/MagicMenu.getId(id)
			$CharacterBody2D/MagicMenu.updateInfoMagic()
			$CharacterBody2D/MapMenu.visible = false
		"FormationReady":
			storedID = id
			actionList.append("FormationSwap")
		"FormationSwap":
			var tempFormationID = int(GlobalVariables.team_formation[storedID])
			GlobalVariables.team_formation[storedID] = int(GlobalVariables.team_formation[id])
			GlobalVariables.team_formation[id] = tempFormationID
			get_node("CharacterBody2D/MapMenu/CharSlot" + str(storedID)).showCharInfo()
			get_node("CharacterBody2D/MapMenu/CharSlot" + str(id)).showCharInfo()
			actionList.pop_back()

func itemPressed():
	actionList.append("Item")
	$CharacterBody2D/ItemMenu.visible = true
	$CharacterBody2D/ItemMenu.updateInfoItem()
	$CharacterBody2D/MapMenu.visible = false

func weaponPressed():
	showArmorWeaponMenu(0)
	
func armorPressed():
	showArmorWeaponMenu(1)

func showArmorWeaponMenu(isArmor : int):
	actionList.append("ArmorWeapon")
	$CharacterBody2D/ArmorWeaponMenu.visible = true
	$CharacterBody2D/ArmorWeaponMenu.updateArmorWeaponMenu(isArmor)
	$CharacterBody2D/MapMenu.visible = false
