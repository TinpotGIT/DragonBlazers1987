extends Sprite2D

func save_game():
	var save = {}
	for i in range(4):
		save[str(i)] = {}
		saveChar(i, save[str(i)])
	save["Inventory"] = GlobalVariables.global_item_inventory
	save["Gold"] = GlobalVariables.gold
	var save_file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	save_file.store_string(str(save))
	save_file.close()

func saveChar(charID, currentSave):
	currentSave["Name"] = GlobalVariables.global_names[charID]
	currentSave["Id"] = GlobalVariables.global_allies[charID]
	currentSave["Formation"] = GlobalVariables.team_formation[charID]
	currentSave["Status"] = GlobalVariables.global_status[charID]
	currentSave["Exp"] = {}
	currentSave["Exp"]["Level"] = GlobalVariables.global_levels[charID]
	currentSave["Exp"]["CurrentExp"] = GlobalVariables.global_exp[charID]
	currentSave["Exp"]["TotalExp"] = GlobalVariables.total_exp[charID]
	currentSave["Stats"] = {}
	currentSave["Stats"]["HP"] = GlobalVariables.global_hp[charID][0]
	currentSave["Stats"]["HP_MAX"] = GlobalVariables.global_hp[charID][1]
	currentSave["Stats"]["STR"] = GlobalVariables.global_stats[charID][0]
	currentSave["Stats"]["AGL"] = GlobalVariables.global_stats[charID][1]
	currentSave["Stats"]["INT"] = GlobalVariables.global_stats[charID][2]
	currentSave["Stats"]["VIT"] = GlobalVariables.global_stats[charID][3]
	currentSave["Stats"]["LUCK"] = GlobalVariables.global_stats[charID][4]
	currentSave["Stats"]["ACC"] = GlobalVariables.global_stats[charID][5]
	currentSave["Stats"]["MDEF"] = GlobalVariables.global_stats[charID][6]
	currentSave["Magic"] = {}
	currentSave["Magic"]["Charges"] = GlobalVariables.global_charges[charID]
	currentSave["Magic"]["Spells"] = GlobalVariables.global_spells[charID]
	currentSave["Equipment"] = {}
	currentSave["Equipment"]["Weapons"] = GlobalVariables.global_equipment_inventory[charID][0]
	currentSave["Equipment"]["Armor"] = GlobalVariables.global_equipment_inventory[charID][1]
	currentSave["Equipment"]["EquippedWeapons"] = GlobalVariables.global_is_equipped[charID][0]
	currentSave["Equipment"]["EquippedArmor"] = GlobalVariables.global_is_equipped[charID][1]
