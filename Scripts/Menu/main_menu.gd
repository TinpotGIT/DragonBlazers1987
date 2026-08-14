extends Control

var ally1 = 0
var ally2 = 1
var ally3 = 2
var ally4 = 3
var allies = [ally1, ally2, ally3, ally4]

var save = {}

var classNames = ["COMBATT.", "VOLEUR", "CEINT.NOIR", "MAGE RGE", "MAGE BLC", "MAGE NOIR"]
var classImgs = ["fighter", "thief", "bbelt", "rmage", "wmage", "bmage"]

var defaultHP = [35, 30, 33, 1, 28, 25]

#STR, AGL, INT, VIT, LUCK, ACC, MDEF
var defaultStats = [
	[20, 5, 1, 10, 5, 64, 15],
	[5, 10, 5, 5, 15, 10, 15],
	[5, 5, 5, 20, 5, 5, 10],
	[10, 10, 10, 5, 5, 7, 20],
	[5, 5, 15, 10, 5, 5, 20],
	[1, 10, 20, 1, 10, 5, 20]
]

var defaultCharges = [
	[[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]],
	[[2, 2], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]],
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $NewGameMenu.visible == true:
		if Input.is_action_just_pressed("ui_end"):
			newSave()
		elif Input.is_action_just_pressed("escape"):
			$MainMenu.visible = true
			$NewGameMenu.visible = false
			$MainMenu/ContinueButton.grab_focus.call_deferred()

func saveChar(charID, slotNumber):
	save[str(slotNumber)]["Name"] = get_node("NewGameMenu/CharName" + str(slotNumber + 1)).text
	save[str(slotNumber)]["Id"] = charID
	save[str(slotNumber)]["Formation"] = slotNumber
	save[str(slotNumber)]["Status"] = ""
	save[str(slotNumber)]["Exp"] = {}
	save[str(slotNumber)]["Exp"]["Level"] = 1
	save[str(slotNumber)]["Exp"]["CurrentExp"] = 0
	save[str(slotNumber)]["Exp"]["TotalExp"] = 0
	save[str(slotNumber)]["Stats"] = {}
	save[str(slotNumber)]["Stats"]["HP_MAX"] = defaultHP[charID]
	save[str(slotNumber)]["Stats"]["HP"] = defaultHP[charID]
	save[str(slotNumber)]["Stats"]["STR"] = defaultStats[charID][0]
	save[str(slotNumber)]["Stats"]["AGL"] = defaultStats[charID][1]
	save[str(slotNumber)]["Stats"]["INT"] = defaultStats[charID][2]
	save[str(slotNumber)]["Stats"]["VIT"] = defaultStats[charID][3]
	save[str(slotNumber)]["Stats"]["LUCK"] = defaultStats[charID][4]
	save[str(slotNumber)]["Stats"]["ACC"] = defaultStats[charID][5]
	save[str(slotNumber)]["Stats"]["MDEF"] = defaultStats[charID][6]
	save[str(slotNumber)]["Magic"] = {}
	save[str(slotNumber)]["Magic"]["Charges"] = defaultCharges[int(charID/4)]
	save[str(slotNumber)]["Magic"]["Spells"] = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
	save[str(slotNumber)]["Equipment"] = {}
	save[str(slotNumber)]["Equipment"]["Weapons"] = [0, 0, 0, 0]
	save[str(slotNumber)]["Equipment"]["Armor"] = [43, 44, 56, 71]
	save[str(slotNumber)]["Equipment"]["EquippedWeapons"] = [false, false, false, false]
	save[str(slotNumber)]["Equipment"]["EquippedArmor"] = [false, false, false, false]

func newSave():
	for i in range(4):
		save[str(i)] = {}
		saveChar(allies[i], i)
	save["Inventory"] = [0, 1, 2, 3, 4, 5]
	save["Gold"] = 400
	print(str(save))
	var save_file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	save_file.store_string(str(save))
	save_file.close()
	loadSave()

func loadSave():
	var loaded_save_file = FileAccess.open("res://savegame.save", FileAccess.READ)
	var content = loaded_save_file.get_as_text()
	var save = JSON.parse_string(content)
	GlobalVariables.global_item_inventory = save["Inventory"]
	GlobalVariables.gold = int(save["Gold"])
	for i in range(4):
		loadBaseInfo(i, save[str(i)])
		loadExp(i, save[str(i)]["Exp"])
		loadStats(i, save[str(i)]["Stats"])
		loadMagic(i, save[str(i)]["Magic"])
		loadEquipment(i, save[str(i)]["Equipment"])
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Map.tscn")

func loadBaseInfo(charSlot, save):
	GlobalVariables.global_names[charSlot] = save["Name"]
	GlobalVariables.global_allies[charSlot] = int(save["Id"])
	GlobalVariables.team_formation[charSlot] = int(save["Formation"])
	GlobalVariables.global_status[charSlot] = save["Status"]

func loadExp(charSlot, save):
	GlobalVariables.global_levels[charSlot] = int(save["Level"])
	GlobalVariables.global_exp[charSlot] = int(save["CurrentExp"])
	GlobalVariables.total_exp[charSlot] = int(save["TotalExp"])

func loadStats(charSlot, save):
	GlobalVariables.global_hp[charSlot] = [int(save["HP"]), int(save["HP_MAX"])]
	GlobalVariables.global_stats[charSlot] = [
		int(save["STR"]), int(save["AGL"]), int(save["INT"]), int(save["VIT"]), 
		int(save["LUCK"]), int(save["ACC"]), int(save["MDEF"])
		]

func loadMagic(charSlot, save):
	GlobalVariables.global_charges[charSlot] = save["Charges"]
	GlobalVariables.global_spells[charSlot] = save["Spells"]

func loadEquipment(charSlot, save):
	GlobalVariables.global_equipment_inventory[charSlot][0] = save["Weapons"]
	GlobalVariables.global_equipment_inventory[charSlot][1] = save["Armor"]
	GlobalVariables.global_is_equipped[charSlot][0] = save["EquippedWeapons"]
	GlobalVariables.global_is_equipped[charSlot][1] = save["EquippedArmor"]

func _on_loading_pressed() -> void:
	loadSave()

func _on_char_1_class_pressed() -> void:
	allyCycle(0)

func _on_char_2_class_pressed() -> void:
	allyCycle(1)

func _on_char_3_class_pressed() -> void:
	allyCycle(2)

func _on_char_4_class_pressed() -> void:
	allyCycle(3)

func allyCycle(charID : int):
	if allies[charID] == 5:
		allies[charID] = 0
	else:
		allies[charID] += 1
	get_node("NewGameMenu/CharTitle" + str(charID + 1)).text = classNames[allies[charID]]
	get_node("NewGameMenu/CharImg" + str(charID + 1)).play(classImgs[allies[charID]])

func _on_new_game_button_pressed() -> void:
	$MainMenu.visible = false
	$NewGameMenu.visible = true
	$NewGameMenu/CharSelect1.grab_focus.call_deferred()


func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 10, get_node(extra_arg_0).position.y + 19)
