extends Control

var ally1 = 0
var ally2 = 0
var ally3 = 0
var ally4 = 0
var allies = [ally1, ally2, ally3, ally4]

var save = {
	"0": {
		"Id": 0,
		"Name": "",
		"Level": 1,
		"Stats": { "HP_MAX": 0, "HP" : 0, "STR": 0, "AGL": 0, "INT": 0, "VIT": 0, "LUCK": 0, "ACC": 0, "MDEF": 0},
		"Charges": {
			"CANUSE": false,
			"LV1":{ "MAX": 0, "CURRENT": 0 },
			"LV2":{ "MAX": 0, "CURRENT": 0 },
			"LV3":{ "MAX": 0, "CURRENT": 0 },
			"LV4":{ "MAX": 0, "CURRENT": 0 },
			"LV5":{ "MAX": 0, "CURRENT": 0 },
			"LV6":{ "MAX": 0, "CURRENT": 0 },
			"LV7":{ "MAX": 0, "CURRENT": 0 },
			"LV8":{ "MAX": 0, "CURRENT": 0 },
		},
		"Status": "None",
		"WeaponInventory": [0, 0, 0, 0],
		"ArmorInventory": [0, 0, 0, 0],
		"MagicInventory": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], 
						   [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	},
	"1": {
		"Id": 0,
		"Name": "",
		"Level": 1,
		"Stats": { "HP_MAX": 0, "HP" : 0, "STR": 0, "AGL": 0, "INT": 0, "VIT": 0, "LUCK": 0, "ACC": 0, "MDEF": 0},
		"Charges": {
			"CANUSE": false,
			"LV1":{ "MAX": 0, "CURRENT": 0 },
			"LV2":{ "MAX": 0, "CURRENT": 0 },
			"LV3":{ "MAX": 0, "CURRENT": 0 },
			"LV4":{ "MAX": 0, "CURRENT": 0 },
			"LV5":{ "MAX": 0, "CURRENT": 0 },
			"LV6":{ "MAX": 0, "CURRENT": 0 },
			"LV7":{ "MAX": 0, "CURRENT": 0 },
			"LV8":{ "MAX": 0, "CURRENT": 0 },
		},
		"Status": "None",
		"WeaponInventory": [0, 0, 0, 0],
		"ArmorInventory": [0, 0, 0, 0],
		"MagicInventory": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], 
						   [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	},
	"2": {
		"Id": 0,
		"Name": "",
		"Level": 1,
		"Stats": { "HP_MAX": 0, "HP" : 0, "STR": 0, "AGL": 0, "INT": 0, "VIT": 0, "LUCK": 0, "ACC": 0, "MDEF": 0},
		"Charges": {
			"CANUSE": false,
			"LV1":{ "MAX": 0, "CURRENT": 0 },
			"LV2":{ "MAX": 0, "CURRENT": 0 },
			"LV3":{ "MAX": 0, "CURRENT": 0 },
			"LV4":{ "MAX": 0, "CURRENT": 0 },
			"LV5":{ "MAX": 0, "CURRENT": 0 },
			"LV6":{ "MAX": 0, "CURRENT": 0 },
			"LV7":{ "MAX": 0, "CURRENT": 0 },
			"LV8":{ "MAX": 0, "CURRENT": 0 },
		},
		"Status": "None",
		"WeaponInventory": [0, 0, 0, 0],
		"ArmorInventory": [0, 0, 0, 0],
		"MagicInventory": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], 
						   [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	},
	"3": {
		"Id": 0,
		"Name": "",
		"Level": 1,
		"Stats": { "HP_MAX": 0, "HP" : 0, "STR": 0, "AGL": 0, "INT": 0, "VIT": 0, "LUCK": 0, "ACC": 0, "MDEF": 0},
		"Charges": {
			"CANUSE": false,
			"LV1":{ "MAX": 0, "CURRENT": 0 },
			"LV2":{ "MAX": 0, "CURRENT": 0 },
			"LV3":{ "MAX": 0, "CURRENT": 0 },
			"LV4":{ "MAX": 0, "CURRENT": 0 },
			"LV5":{ "MAX": 0, "CURRENT": 0 },
			"LV6":{ "MAX": 0, "CURRENT": 0 },
			"LV7":{ "MAX": 0, "CURRENT": 0 },
			"LV8":{ "MAX": 0, "CURRENT": 0 },
		},
		"Status": "None",
		"WeaponInventory": [0, 0, 0, 0],
		"ArmorInventory": [0, 0, 0, 0],
		"MagicInventory": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], 
						   [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	},
	"Inventory": [15, 0, 0]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func newSave():	
	
	GlobalVariables.global_allies[0] = ally1
	GlobalVariables.global_allies[1] = ally2
	GlobalVariables.global_allies[2] = ally3
	GlobalVariables.global_allies[3] = ally4
	
	for i in range(4):
		if i == 0:
			save[str(i)]["Name"] = $Char1Name.text
		elif i == 1:
			save[str(i)]["Name"] = $Char2Name.text
		elif i == 2:
			save[str(i)]["Name"] = $Char3Name.text
		elif i == 3:
			save[str(i)]["Name"] = $Char4Name.text
			
		if GlobalVariables.global_allies[i] == 0:
			#WARRIOR
			save[str(i)]["Id"] = 0
			save[str(i)]["Stats"]["HP_MAX"] = 35
			save[str(i)]["Stats"]["HP"] = 35
			save[str(i)]["Stats"]["STR"] = 20
			save[str(i)]["Stats"]["AGL"] = 5
			save[str(i)]["Stats"]["INT"] = 1
			save[str(i)]["Stats"]["VIT"] = 10
			save[str(i)]["Stats"]["LUCK"] = 5
			save[str(i)]["Stats"]["MDEF"] = 15
			save[str(i)]["Stats"]["ACC"] = 5
			save[str(i)]["WeaponInventory"][0] = 1
			save[str(i)]["ArmorInventory"][1] = 2
		elif GlobalVariables.global_allies[i] == 1:
			#THIEF
			save[str(i)]["Id"] = 1
			save[str(i)]["Stats"]["HP_MAX"] = 30
			save[str(i)]["Stats"]["HP"] = 30
			save[str(i)]["Stats"]["STR"] = 5
			save[str(i)]["Stats"]["AGL"] = 10
			save[str(i)]["Stats"]["INT"] = 5
			save[str(i)]["Stats"]["VIT"] = 5
			save[str(i)]["Stats"]["LUCK"] = 15
			save[str(i)]["Stats"]["MDEF"] = 15
			save[str(i)]["Stats"]["ACC"] = 10
		elif GlobalVariables.global_allies[i] == 2:
			#BBELT
			save[str(i)]["Id"] = 2
			save[str(i)]["Stats"]["HP_MAX"] = 33
			save[str(i)]["Stats"]["HP"] = 33
			save[str(i)]["Stats"]["STR"] = 5
			save[str(i)]["Stats"]["AGL"] = 5
			save[str(i)]["Stats"]["INT"] = 5
			save[str(i)]["Stats"]["VIT"] = 20
			save[str(i)]["Stats"]["LUCK"] = 5
			save[str(i)]["Stats"]["MDEF"] = 10
			save[str(i)]["Stats"]["ACC"] = 5
		elif GlobalVariables.global_allies[i] == 3:
			#RMAGE
			save[str(i)]["Id"] = 3
			save[str(i)]["Stats"]["HP_MAX"] = 30
			save[str(i)]["Stats"]["HP"] = 30
			save[str(i)]["Stats"]["STR"] = 10
			save[str(i)]["Stats"]["AGL"] = 10
			save[str(i)]["Stats"]["INT"] = 10
			save[str(i)]["Stats"]["VIT"] = 5
			save[str(i)]["Stats"]["LUCK"] = 5
			save[str(i)]["Stats"]["MDEF"] = 20
			save[str(i)]["Stats"]["ACC"] = 7
			#CHARGES
			save[str(i)]["Charges"]["CANUSE"] = true
			save[str(i)]["Charges"]["LV1"]["MAX"] = 2
			save[str(i)]["Charges"]["LV1"]["CURRENT"] = 2
		elif GlobalVariables.global_allies[i] == 4:
			#WMAGE
			save[str(i)]["Id"] = 4
			save[str(i)]["Stats"]["HP_MAX"] = 28
			save[str(i)]["Stats"]["HP"] = 28
			save[str(i)]["Stats"]["STR"] = 5
			save[str(i)]["Stats"]["AGL"] = 5
			save[str(i)]["Stats"]["INT"] = 15
			save[str(i)]["Stats"]["VIT"] = 10
			save[str(i)]["Stats"]["LUCK"] = 5
			save[str(i)]["Stats"]["MDEF"] = 20
			save[str(i)]["Stats"]["ACC"] = 5
			save[str(i)]["MagicInventory"][0][1] = 1
			save[str(i)]["MagicInventory"][0][0] = 3
			save[str(i)]["MagicInventory"][0][2] = 5
			save[str(i)]["MagicInventory"][1][0] = 2
			#CHARGES
			save[str(i)]["Charges"]["CANUSE"] = true
			save[str(i)]["Charges"]["LV1"]["MAX"] = 2
			save[str(i)]["Charges"]["LV1"]["CURRENT"] = 2
		elif GlobalVariables.global_allies[i] == 5:
			#BMAGE
			save[str(i)]["Id"] = 5
			save[str(i)]["Stats"]["HP_MAX"] = 25
			save[str(i)]["Stats"]["HP"] = 25
			save[str(i)]["Stats"]["STR"] = 1
			save[str(i)]["Stats"]["AGL"] = 10
			save[str(i)]["Stats"]["INT"] = 20
			save[str(i)]["Stats"]["VIT"] = 1
			save[str(i)]["Stats"]["LUCK"] = 10
			save[str(i)]["Stats"]["MDEF"] = 20
			save[str(i)]["Stats"]["ACC"] = 5
			#CHARGES
			save[str(i)]["Charges"]["CANUSE"] = true
			save[str(i)]["Charges"]["LV1"]["MAX"] = 2
			save[str(i)]["Charges"]["LV1"]["CURRENT"] = 2
	var save_file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	save_file.store_string(str(save))
	print(str(save))
	save_file.close()
	loadSave()
	
func loadSave():
	var loaded_save_file = FileAccess.open("res://savegame.save", FileAccess.READ)
	var content = loaded_save_file.get_as_text()
	save = JSON.parse_string(content)
	print(save)
	print(save["Inventory"])
	GlobalVariables.inventory = save["Inventory"]
	for i in range(4):
		GlobalVariables.global_levels[i] = int(save[str(i)]["Level"])
		GlobalVariables.global_equipment_inventory[i][0] = save[str(i)]["WeaponInventory"]
		GlobalVariables.global_equipment_inventory[i][1] = save[str(i)]["ArmorInventory"]
		print(str(save[str(i)]["Id"]))
		GlobalVariables.global_allies[i] = save[str(i)]["Id"]
		var stats = save[str(i)]["Stats"]
		GlobalVariables.global_names[i] = save[str(i)]["Name"]
		GlobalVariables.global_hp[i] = [stats["HP_MAX"], stats["HP"]]
		GlobalVariables.global_stats[i] = [stats["STR"], stats["AGL"], stats["INT"], stats["VIT"], stats["LUCK"], stats["ACC"], stats["MDEF"]]
		# Loading spells into game memory
		if save[str(i)]["Charges"]["CANUSE"] == true:
			GlobalVariables.global_spells[i] = save[str(i)]["MagicInventory"]
			var charges = save[str(i)]["Charges"]
			GlobalVariables.global_charges[i] = [
				[charges["LV1"]["MAX"], charges["LV1"]["CURRENT"]],
				[charges["LV2"]["MAX"], charges["LV2"]["CURRENT"]],
				[charges["LV3"]["MAX"], charges["LV3"]["CURRENT"]],
				[charges["LV4"]["MAX"], charges["LV4"]["CURRENT"]],
				[charges["LV5"]["MAX"], charges["LV5"]["CURRENT"]],
				[charges["LV6"]["MAX"], charges["LV6"]["CURRENT"]],
				[charges["LV7"]["MAX"], charges["LV7"]["CURRENT"]],
				[charges["LV8"]["MAX"], charges["LV8"]["CURRENT"]]
				]
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Map.tscn")

func _on_loading_pressed() -> void:
	loadSave()

func _on_newsave_pressed() -> void:
	newSave()


func _on_char_1_class_pressed() -> void:
	if ally1 == 5:
		ally1 = 0
		$Char1Class.allyNumber = 0
	else:
		ally1 += 1
		$Char1Class.allyNumber += 1
	
func _on_char_2_class_pressed() -> void:
	if ally2 == 5:
		ally2 = 0
		$Char2Class.allyNumber = 0
	else:
		ally2 += 1
		$Char2Class.allyNumber += 1

func _on_char_3_class_pressed() -> void:
	if ally3 == 5:
		ally3 = 0
		$Char3Class.allyNumber = 0
	else:
		ally3 += 1
		$Char3Class.allyNumber += 1

func _on_char_4_class_pressed() -> void:
	if ally4 == 5:
		ally4 = 0
		$Char4Class.allyNumber = 0
	else:
		ally4 += 1
		$Char4Class.allyNumber += 1
