extends Node2D

signal choose_monsters(groupNum)

var enemies = [[], [], [], [], [], [], [], [], [], [], [], [], []]
var attacking = false
var moving = false

var hitMultiplier = [1, 1, 1, 1]

var totalGold = 0
var totalExp = 0
var existingEnemies = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var itemInUse = 0

var moral = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var battleResistances = []
var teamFormation = GlobalVariables.team_formation

var turn = 0
var turnOrder = []
var totalOrder = 0

var deadAllies = 0
var alive = 0
var dead = 0

var charSelectedID = 0
@onready var charSelected = teamFormation[0]
var currentAction = "None"
var actions = []
var turnFinished = false

var currentWeapon = ""

#ATT ESQ INT VIT LUCK ACC DEF MDEF
var extraStats = [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]

var enemyInfo = [
	[0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""],
	[0, ""], [0, ""], [0, ""], [0, ""]
	]

var allyInfo =  [
	[0, ""], [0, ""], [0, ""], [0, ""]
]

var currentSpell

func _on_summon_monsters(_chosenMonsters, _groupFormation) -> void:
	var groupSize = 0
	for i in range(len(_chosenMonsters)):
		groupSize += len(_chosenMonsters[i])
	createEnemyTeam(_chosenMonsters, _groupFormation, groupSize)
	showEnemyNames(_chosenMonsters)

func _ready() -> void:
	choose_monsters.emit(GlobalVariables.next_battle)
	for i in range(4):
		var char = get_node("Char" + str(i))
		char.animationCheck(GlobalVariables.global_allies[teamFormation[i]])
		char.idle()
	hideCursor()
	onCharSelected()
	checkAlive()
	goldGained()
	expGained()
	battleResistances = GlobalVariables.global_resistances.duplicate()

func _process(delta: float) -> void:
	if deadAllies == 4:
		deadAllies = 0
		showBattleUI()
		$BattleInfo/InfoUI_Bar/Text.text = "You lost!"
		$LoseTimer.start()
	if Input.is_action_just_pressed("escape"):
			actionBack()

func actionBack():
	var formation = teamFormation
	if currentAction == "None" and charSelectedID != 0:
		currentAction = "Back"
		var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
		anPlayer.play("runback_animation_" + str(charSelectedID))
	else:
		match currentAction:
			"AttackChoice":
				$CommandUI/Button.grab_focus()
				currentAction = "None"
			"MagicChoice":
				$MagicMenu/UI.visible = false
				$CommandUI/Button.grab_focus()
				currentAction = "None"
			"CastingSpell":
				$MagicMenu/UI/M1_1.grab_focus()
				currentAction = "MagicChoice"
			"InventoryChoice":
				$ItemMenu/UI.visible = false
				$CommandUI/Button.grab_focus()
			"UsingItem":
				currentAction = "InventoryChoice"
				$ItemMenu/UI/W_0.grab_focus()

# Character check functions
func checkAlive():
	for i in range(len(enemies)):
		if enemies[i] != []:
			if enemies[i][1][0] > 0:
				alive += 1

func findAliveAlly():
	if deadAllies == 4:
		showBattleUI()
		$BattleInfo/InfoUI_Bar/Text.text = "You lost!"
		$LoseTimer.start()
	else:
		while (GlobalVariables.global_hp[teamFormation[charSelectedID]][0] <= 0) and deadAllies != 4:
			actions.append([-1, -1, 0])
			if charSelectedID == 3:
				turnFinished = true
				charSelectedID = 0
				playTurn()
			else:
				charSelectedID += 1

func onCharSelected():
	findAliveAlly()
	var char : AnimatedSprite2D = get_node("Char" + str(charSelectedID))
	var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
	char.play(char.run_name)
	anPlayer.play("run_animation_" + str(charSelectedID))

# Scene building functions 

func createEnemyTeam(chosenMonsters, groupFormation, groupSize):
	var enemyCountSmall = 0
	var enemyCountMedium = 9
	var chosenCount = 0
	var totalEnemies = 0
	var maxEnemies = getMaxEnemies(groupFormation)
	for i in range(len(chosenMonsters)):
		var enemyData = getEnemyData(chosenMonsters[i])
		for j in range(len(chosenMonsters[i])):
			if chosenMonsters[i][0] >= 62:
				if (enemyCountMedium-9 < maxEnemies[1]):
					chosenCount = enemyCountMedium
					enemyCountMedium += 1
					enemies[chosenCount] = [chosenMonsters[i][0], enemyData.duplicate(), ""].duplicate()
					duplicate()
					totalEnemies += 1
			else:
				if (enemyCountSmall < maxEnemies[0]):
					chosenCount = enemyCountSmall
					enemyCountSmall += 1
					enemies[chosenCount] = [chosenMonsters[i][0], enemyData.duplicate(), ""].duplicate()
					totalEnemies += 1
	showEnemyTeam(groupFormation, maxEnemies)

func showEnemyTeam(groupFormation, maxEnemies):
	var smallCounter = 0
	var mediumCounter = 0
	var enemyCounter = 0
	var enemyName = "enemyS_"
	var max = maxEnemies[0]
	changeFormation(groupFormation)
	for i in range(len(enemies)):
		if enemies[i] != []:
			if enemies[i][0] >= 62 and enemyName != "enemyM_":
				enemyName = "enemyM_"
				max = maxEnemies[1]
				smallCounter = enemyCounter
				enemyCounter = mediumCounter
			elif enemies[i][0] < 62 and enemyName != "enemyS_":
				enemyName = "enemyS_"
				max = maxEnemies[0]
				mediumCounter = enemyCounter
				enemyCounter = smallCounter
			if enemyCounter < max:
				var enemy = get_node(enemyName + str(enemyCounter))
				enemy.show()
				enemy.texture_normal = load(enemies[i][1][16])
				enemyCounter += 1
	changeFormationFocus(groupFormation)

func getMaxEnemies(groupFormation):
	match groupFormation:
		1: return [9, 0]
		2: return [6, 2]
		3: return [0, 4]

func getEnemyData(chosenMonster):
	var EnemyList = $Battle_UI.Monsters
	var enemyData = EnemyList[chosenMonster[0]].duplicate()
	return enemyData

func changeFormation(groupFormation):
	var smallSize = 9
	match groupFormation:
		2: 
			smallSize = 6
	for i in range(smallSize):
		var enemy = get_node("enemyS_" + str(i))
		if i < 3: 
			if smallSize == 9: enemy.position = Vector2(8, enemy.position.y)
			else: enemy.position = Vector2(55, enemy.position.y)
		elif i < 6:
			if smallSize == 9: enemy.position = Vector2(40, enemy.position.y)
			else: enemy.position = Vector2(87, enemy.position.y)
		else: enemy.position = Vector2(72, enemy.position.y)

func changeFormationFocus(groupFormation):
	if groupFormation == 2:
		get_node("enemyM_0").set_focus_neighbor(SIDE_RIGHT, "../enemyS_0")
		get_node("enemyM_1").set_focus_neighbor(SIDE_RIGHT, "../enemyS_0")
		get_node("enemyS_0").set_focus_neighbor(SIDE_LEFT, "../enemyM_0")
		get_node("enemyS_1").set_focus_neighbor(SIDE_LEFT, "../enemyM_0")
		get_node("enemyS_2").set_focus_neighbor(SIDE_LEFT, "../enemyM_0")

func showEnemyNames(chosenMonsters):
	var currentText = 1
	var currentMonster = 0
	var nameList = []
	for i in range(len(chosenMonsters)):
		if len(chosenMonsters) < 5 and currentText <= 7:
			var chosenEnemy = get_node("EnemiesUI").Names[chosenMonsters[i][0]]
			get_node("EnemiesUI/EnemyText" + str(currentText)).text = chosenEnemy[1]
			currentText += 2
			nameList.append([chosenEnemy[0], chosenEnemy[1]])
		elif len(chosenMonsters) >= 5:
			var chosenEnemy = get_node("EnemiesUI").Names[chosenMonsters[i][0]]
			get_node("EnemiesUI/EnemyText" + str(i)).text = chosenEnemy[1]
			nameList.append([chosenEnemy[0], chosenEnemy[1]])

func goldGained():
	for i in range(len(enemies)):
		if enemies[i] != []:
			totalGold += enemies[i][1][-3]
	print("Gold that will be gained is : " + str(totalGold))

func expGained():
	for i in range(len(enemies)):
		if enemies[i] != []:
			totalExp += enemies[i][1][-2]
	print("Exp that will be gained is : " + str(totalExp))

# Cursor functions (Focus)

func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 10, get_node(extra_arg_0).position.y + 19)

func _on_enemy_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x, get_node(extra_arg_0).position.y + 19)

func _on_spell_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 5, get_node(extra_arg_0).position.y + 23)

func _on_char_focus_entered(extra_arg_0: NodePath, id: int) -> void:
	if teamFormation[charSelectedID] == id:
		$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 25, get_node(extra_arg_0).position.y + 19)
	else:
		$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 10, get_node(extra_arg_0).position.y + 19)

func hideCursor():
	$HandCursor.visible = false

func showCursor():
	$HandCursor.visible = true

# Targeting functions
func _on_enemy_pressed(extra_arg_0: int) -> void:
	if enemies[extra_arg_0] != [] and enemies[extra_arg_0][1][0] > 0:
		if currentAction == "CastingSpell":
			actions.append([extra_arg_0, currentSpell, 0])
		elif currentAction == "UsingItem":
			actions.append([extra_arg_0, 0, itemInUse])
		else:
			actions.append([extra_arg_0, 0, 0])
		if $MagicMenu/UI.visible == true:
			$MagicMenu/UI.visible = false
		$HandCursor.visible = false
		get_viewport().gui_release_focus()
		currentAction = "None"
		var char = get_node("Char" + str(charSelectedID))
		var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
		anPlayer.play("runback_animation_" + str(charSelectedID))
		char.play(char.run_name)

func _on_char_select_pressed(id) -> void:
	actions.append([20+teamFormation[id], currentSpell, 0])
	if $MagicMenu/UI.visible == true:
			$MagicMenu/UI.visible = false
	$HandCursor.visible = false
	get_viewport().gui_release_focus()
	currentAction = "None"
	var char = get_node("Char" + str(charSelectedID))
	var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
	anPlayer.play("runback_animation_" + str(charSelectedID))
	char.play(char.run_name)

#Inventory functions
func inventoryChoice():
	$ItemMenu/UI.visible = true
	$ItemMenu/UI/W_0.grab_focus.call_deferred()
	showInventory()

func showInventory():
	var charInventory = GlobalVariables.global_equipment_inventory[charSelectedID]
	var weapons = charInventory[0]
	var armor = charInventory[1]
	for i in range(4):
		get_node("ItemMenu/UI/W_" + str(i)).text = $ItemMenu.items[weapons[i]][0]
		get_node("ItemMenu/UI/A_" + str(i)).text = $ItemMenu.items[armor[i]][0]
		get_node("ItemMenu/UI/IW_" + str(i)).texture = load($ItemMenu.items[weapons[i]][6])
		get_node("ItemMenu/UI/IA_" + str(i)).texture = load($ItemMenu.items[armor[i]][6])

func _on_items_pressed() -> void:
	currentAction = "InventoryChoice"
	inventoryChoice()

func _on_item_button_pressed(isArmor, id) -> void:
	var item = GlobalVariables.global_equipment_inventory[teamFormation[charSelectedID]][isArmor][id]
	var itemList = $ItemMenu.items
	var spellID = itemList[item][2]
	if itemList[item][2] != 0:
		currentAction = "UsingItem"
		var spell = $MagicMenu.Spells[spellID]
		spellTarget(spell, spellID)
	elif isArmor == 0:
		currentAction = "UsingItem"
		itemInUse = item
		attackChoice()

func itemAttack(charID, id):
	var CharID = teamFormation[charSelectedID]
	attackAction(CharID, id)

# General animation functions 
func _on_animation_finished_char0(anim_name: StringName) -> void:
	var char : AnimatedSprite2D = get_node("Char" + str(charSelectedID))
	char.idle()
	if turnFinished == false:
		if anim_name == ("run_animation_" + str(charSelectedID)):
			showCursor()
			$CommandUI/Button.grab_focus.call_deferred()
		if anim_name == ("runback_animation_" + str(charSelectedID)):
			if currentAction == "Back":
				charSelectedID -= 1
				actions.pop_back()
			elif charSelectedID < 3:
				charSelectedID += 1
				findAliveAlly()
				print(charSelectedID)
				charSelected = teamFormation[charSelectedID]
				onCharSelected()
			currentAction = "None"
			if charSelectedID == 3:
				if len(actions) == 4 and turnFinished == false:
					turnFinished = true
					playTurn()

func _on_animation_finished_1(anim_name: StringName) -> void:
	var char = get_node("Char" + str(charSelectedID))
	if anim_name.begins_with("run_animation_") and turnFinished:
		char.idle()
		var actionTarget = actions[teamFormation[charSelectedID]][0]
		var actionID = actions[teamFormation[charSelectedID]][1]
		if actionID == 0:
			allyAttackAnimation()
			$AttackTimer.start()
		else:
			allySpellAnimation(actionID, actionTarget)
			$SpellTimer.start()
	elif anim_name.begins_with("runback_animation_") and turnFinished:
		char.idle()

func allyAttackAnimation():
	var animationPlayer = get_node("AnimationPlayer1")
	if currentWeapon != "":
		$Weapon.play(currentWeapon)
		animationPlayer.play("attack_animation_" + str(charSelectedID))
	get_node("Char"+str(charSelectedID)).attack()

func allySpellAnimation(spellID, target):
	var spells = $MagicMenu.Spells
	var targetNode : Node
	get_node("Char"+str(charSelectedID)).victory()
	if target == 30:
		allSpellsAnimationEnemies(spellID)
	elif target == 31:
		allSpellsAnimationAllies(spellID)
	else:
		if target >= 20:
			targetNode = get_node("spell_char"+str(teamFormation[target-20]))
			targetNode.position.x = get_node("Char"+str(teamFormation[target-20])).position.x
			targetNode.show()
			targetNode.play("spell"+str(spells[spellID][8])+"_"+str(spells[spellID][9]))
		else:
			targetNode = get_node("spell_enemy_"+str(target))
			targetNode.show()
			targetNode.play("spell"+str(spells[spellID][8])+"_"+str(spells[spellID][9]))

func allSpellsAnimationEnemies(spellID):
	var spells = $MagicMenu.Spells
	for i in range(len(enemies)):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			if i > 8:
				if get_node("enemyM_"+str(i-9)).visible == true:
					get_node("spell_enemy_"+str(i-9)).show()
					get_node("spell_enemy_"+str(i-9)).play("spell"+str(spells[spellID][8])+"_"+str(spells[spellID][9]))
			if get_node("enemyS_"+str(i)).visible == true:
				get_node("spell_enemy_"+str(i)).show()
				get_node("spell_enemy_"+str(i)).play("spell"+str(spells[spellID][8])+"_"+str(spells[spellID][9]))

func allSpellsAnimationAllies(spellID):
	var spells = $MagicMenu.Spells
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]][0] > 0:
			var targetNode = get_node("spell_char"+str(teamFormation[i]))
			targetNode.position.x = get_node("Char"+str(teamFormation[i])).position.x
			targetNode.show()
			targetNode.play("spell"+str(spells[spellID][8])+"_"+str(spells[spellID][9]))

func hideAllSpellsEnemies():
	for i in range(len(enemies)):
		if get_node("spell_enemy_"+str(i)).visible == true:
			get_node("spell_enemy_"+str(i)).hide()

func hideAllSpellsAllies():
	for i in range(4):
		get_node("spell_char"+str(i)).hide()

# Turns and Actions functions (0 to 8 small enemies, 9 to 12 medium enemies, 20 to 23 allies)
func getTurnOrder():
	var enemylist = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	var allylist = [20, 21, 22, 23]
	var order = [] 	
	while len(order) != 17:
		var random = randi_range(0,1)
		var randomChar = -1
		if random == 0 and len(allylist) > 0:
			randomChar = allylist.pick_random()
			order.append(randomChar)
			allylist.erase(randomChar)
		else:
			randomChar = enemylist.pick_random()
			order.append(randomChar)
			enemylist.erase(randomChar)
	return order

func playTurn():
	var foundChar = false
	var attackName = ""
	hideInfo()
	showBattleUI()
	
	if totalOrder == 0:
		turnOrder = getTurnOrder()

	if dead >= alive:
		showBattleUI()
		$BattleInfo/InfoUI_Bar/Text.text = "You won!"
		$WinTimer.start()
	else:
		while foundChar == false:
			if turnOrder != []:
				if turnOrder[0] >= 20 and (GlobalVariables.global_hp[teamFormation[turnOrder[0] - 20]][0] > 0) and (dead < alive):
						charSelectedID = turnOrder[0] - 20
						$AnimationPlayer1.play("run_animation_" + str(charSelectedID))
						var char = get_node("Char" + str(charSelectedID))
						char.play(char.run_name)
						$ActionBuffer.start()
						foundChar = true
				elif turnOrder[0] < 20 and enemies[turnOrder[0]] != [] and enemies[turnOrder[0]][1][0] > 0:
						print("enemy attacking")
						print(turnOrder)
						enemyAction(turnOrder[0])
						attackName = getActionName(0)
						showInfo(turnOrder[0], attackName)
						$ActionBuffer.start()
						foundChar = true
				totalOrder += 1
				turnOrder.pop_front()
			else:
				print("the total order is " + str(totalOrder))
				foundChar = true
				checkOrder()

func checkOrder():
	if totalOrder != 17:
		playTurn()
	else:
		charSelectedID = 0
		findAliveAlly()
		turnOrder = []
		totalOrder = 0
		actions = []
		turnFinished = false
		$BattleInfo.visible = false
		$CommandUI.visible = true
		$EnemiesUI.z_index = 0
		$HandCursor.visible = true
		$CommandUI/Button.grab_focus()

func getActionName(actionID):
	match actionID:
		0:
			return "ATTACKS"
		_:
			return "LANCE " + $MagicMenu.Spells[actionID][0]

func enemyAction(i):
	if ((enemies[i] != []) and (enemies[i][1][0] > 0)):
		var target = targetAlly()
		var nbHit = enemies[i][1][3]
		enemyAttack(i, target, nbHit)

func targetAlly():
	var randAlly = randi_range(1, 8)
	if randAlly <= 4:
		return 0
	elif randAlly <= 6:
		return 1
	elif randAlly == 7:
		return 2
	else: return 3

# Magic Menu functions 
func _on_magic_pressed() -> void:
	currentAction = "MagicChoice"
	magicChoice()

func magicChoice():
	$MagicMenu/UI.visible = true
	$MagicMenu/UI/M1_1.grab_focus.call_deferred()
	showSpells()

func showSpells():
	var spells = GlobalVariables.global_spells
	for i in range((len(spells[charSelected]))):
		for j in range((len(spells[charSelected][0]))):
			get_node("MagicMenu/UI/M"+str(i+1)+"_"+str(j+1)).text = $MagicMenu.Spells[spells[charSelected][i][j]][0]

func _on_spell_pressed(extra_arg_0: Array) -> void:
	var spellID = GlobalVariables.global_spells[charSelected][extra_arg_0[0]][extra_arg_0[1]]
	var spell = $MagicMenu.Spells[spellID]
	currentAction = "CastingSpell"
	spellTarget(spell, spellID)

func spellTarget(spell, spellID):
	var target_type = spell[4]
	currentSpell = spellID
	if target_type != "R":
		match target_type:
			"SE":
				if $enemyM_0.is_visible_in_tree():
					$enemyM_0.grab_focus.call_deferred()
				else:
					$enemyS_0.grab_focus.call_deferred()
			"SA":
				$CharSelect1.grab_focus.call_deferred()
			_:
				match target_type:
					"AE":
						actions.append([30, spellID, 0])
						$ItemMenu/UI.visible = false
					"AA":
						actions.append([31, spellID, 0])
						$ItemMenu/UI.visible = false
					"C":
						actions.append([20+teamFormation[charSelectedID], spellID, 0])
						$ItemMenu/UI.visible = false
				$MagicMenu/UI.visible = false
				$HandCursor.visible = false
				get_viewport().gui_release_focus()
				var char = get_node("Char" + str(charSelectedID))
				var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
				anPlayer.play("runback_animation_" + str(charSelectedID))
				char.play(char.run_name)

# Main Spell Function
func Spells(target, spellID):
	var spells = $MagicMenu.Spells
	var spell = spells[spellID]
	
	match spell[5]:
		0:
			var spellHealing = randi_range(spell[1], spell[1]*2)
			spellHeal(spellHealing, target)
		1:	
			var spellDamage = randi_range(spell[1], spell[1]*2)
			spellDamage(spellDamage, target, spell)
		2:
			var statusValue = spell[1][0]
			spellStatChange(statusValue, target, spell)
		3:
			spellStatus(target, spell)
		4:
			StatusCure(target, spell)
		5:
			AddResistance(target, spell)
		6:
			addHitMul(target, spell)
		7:
			RemoveResistance(target, spell)

# Spells
func spellHeal(heal, target):
	if target >= 20:
		if target == 30:
			spellHealAllEnemies(heal)
		elif target == 31:
			spellHealAllAllies(heal)
		else:
			spellHealAlly(heal, target)
	else:
		spellHealEnemy(heal, target)

func spellDamage(damage, target, spell):
	if target >= 20:
		if target == 30:
			spellDamageAllEnemies(damage, spell)
		elif target == 31:
			spellDamageAllAllies(damage, spell)
		else:
			spellDamageAlly(damage, target, spell)
	else:
		spellDamageEnemy(damage, target, spell)

func spellStatChange(statusValue, target, spell):
	if target >= 20:
		if target == 30:
			spellStatChangeAllEnemies(statusValue, spell)
		elif target == 31:
			spellStatChangeAllAllies(statusValue, spell)
		else:
			spellStatChangeAlly(statusValue, target, spell)
	else:
		spellStatChangeEnemy(statusValue, target, spell)

func spellStatus(target, spell):
	if target >= 20:
		if target == 30:
			spellStatusAllEnemies(spell)
		elif target == 31:
			spellStatusAllAllies(spell)
		else:
			spellStatusAlly(target, spell)
	else:
		spellStatusEnemy(target, spell)

func StatusCure(target, spell):
	if target >= 20:
		if target == 30:
			allEnemiesStatusCure(spell)
		elif target == 31:
			allAlliesStatusCure(spell)
		else:
			allyStatusCure(target, spell)
	else:
		enemyStatusCure(target, spell)
		
func AddResistance(target, spell):
	if target >= 20:
		if target == 30:
			allEnemiesAddResistance(spell)
		elif target == 31:
			allAlliesAddResistance(spell)
		else:
			allyAddResistance(target, spell)
	else:
		enemyAddResistance(target, spell)
	
func RemoveResistance(target, spell):
	if target >= 20:
		if target == 30:
			allEnemiesRemoveResistance(spell)
		elif target == 31:
			allAlliesRemoveResistance(spell)
		else:
			allyRemoveResistance(target, spell)
	else:
		enemyRemoveResistance(target, spell)

func addHitMul(target, spell):
	if target >= 20:
		addHitMulAlly(target, spell)
	else:
		addHitMulEnemy(target, spell)

func spellHealAlly(heal, target):
	GlobalVariables.global_hp[teamFormation[target-20]][0] += heal
	if (GlobalVariables.global_hp[teamFormation[target-20]][0] > GlobalVariables.global_hp[teamFormation[target-20]][1]):
		GlobalVariables.global_hp[teamFormation[target-20]][0] = GlobalVariables.global_hp[teamFormation[target-20]][1]
		allyInfo[teamFormation[target-20]][0] -= int(heal)

func spellHealEnemy(heal, target):
	enemies[target][1][0] += heal
	enemyInfo[target][0] -= int(heal)
	if enemies[target][1][0] > $Battle_UI.Monsters[enemies[target][0]][0]:
		enemies[target][1][0] = $Battle_UI.Monsters[enemies[target][0]][0]

func spellHealAllEnemies(heal):
	for i in range(len(enemies)):
		if enemies[i] != []:
			spellHealEnemy(heal, i)

func spellHealAllAllies(heal):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]] != 0:
			spellHealAlly(heal, i)

func spellDamageEnemy(damage, target, spell):
	var targets = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	var target_found = false
	while target_found == false:
		if enemies[target] != [] and enemies[target][1][0] > 0:
			var weakCoef = enemyTargetElementCheck(spell, target)
			enemies[target][1][0] -= damage * weakCoef
			enemyInfo[target][0] += int(damage * weakCoef)
			enemyInfo[target][2] = 0
			if enemies[target][1][0] <= 0:
				enemies[target] = []
				dead += 1
		targets.erase(target)
		target = targets.pick_random()

func spellDamageAllEnemies(damage, spell):
	for i in range(13):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			var weakCoef = enemyTargetElementCheck(i, spell)
			enemies[i][1][0] -= damage * weakCoef
			enemyInfo[i][0] += int(damage * weakCoef)
			if enemies[i][1][0] <= 0:
				enemies[i] = []
				dead += 1

func spellDamageAlly(damage, target, spell):
	var targets = [0, 1, 2, 3]
	var target_found = false
	while target_found == false:
		if GlobalVariables.global_hp[teamFormation[target-20]][0] > 0:
			var weakCoef = allyTargetElementCheck(spell, target)
			GlobalVariables.global_hp[teamFormation[target-20]][0] -= damage * weakCoef
			allyInfo[teamFormation[target-20]][0] += int(damage * weakCoef)
			allyCheckAlive(teamFormation[target-20])
		targets.erase(target)
		target = targets.pick_random()

func spellDamageAllAllies(damage, spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]][0] > 0:
			var weakCoef = allyTargetElementCheck(spell, i+20)
			GlobalVariables.global_hp[teamFormation[i]][0] -= damage * weakCoef
			allyInfo[teamFormation[i]][0] += int(damage * weakCoef)
			allyCheckAlive(teamFormation[i])

func spellStatChangeEnemy(statusValue, target, spell):
		match spell[1][1]:
			9:
				moral[target] += statusValue
			_:
				enemies[target][1][spell[1][1]] += statusValue

func spellStatChangeAllEnemies(statusValue, spell):
	for i in range(13):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			match spell[1][1]:
				9:
					moral[i] += statusValue
				_:
					enemies[i][1][spell[1][1]] += statusValue

func spellStatChangeAlly(statusValue, target, spell):
		extraStats[teamFormation[target-20]][spell[1][1]] += statusValue

func spellStatChangeAllAllies(statusValue, spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]][0] > 0:
			extraStats[teamFormation[i]][spell[1][1]] += statusValue

func spellStatusEnemy(target, spell):
	var baseChance = 148
	var weaknessList : Array = enemies[target][1][-5]
	var resistanceList : Array = enemies[target][1][-4]
	if resistanceList.find(spell[3]):
		baseChance = 0
	if weaknessList.find(spell[3]):
		baseChance += 40
	var chance = baseChance + spell[2] - enemies[target][1][7]
	var hitNumber = randi_range(0, 200)
	if hitNumber <= chance:
		enemies[target][2] = spell[1]

func spellStatusAllEnemies(spell):
	for i in range(len(enemies)):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			var baseChance = 148
			var weaknessList : Array = enemies[i][1][-5]
			var resistanceList : Array = enemies[i][1][-4]
			if resistanceList.find(spell[3]):
				baseChance = 0
			if weaknessList.find(spell[3]):
				baseChance += 40
			var chance = baseChance + spell[2] - enemies[i][1][7]
			var hitNumber = randi_range(0, 200)
			if hitNumber <= chance:
				enemies[i][2] = spell[1]

func spellStatusAlly(target, spell):
	var baseChance = 148
	var resistanceList : Array = battleResistances[teamFormation[target-20]]
	if resistanceList.find(spell[3]):
		baseChance = 0
	var chance = baseChance + spell[2] - GlobalVariables.global_stats[teamFormation[target-20]][-1]
	var hitNumber = randi_range(0, 200)
	if hitNumber <= chance:
		GlobalVariables.global_status[teamFormation[target-20]] = spell[1]

func spellStatusAllAllies(spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]] > 0:
			var baseChance = 148
			var resistanceList : Array = battleResistances[teamFormation[i]]
			if resistanceList.find(spell[3]):
				baseChance = 0
			var chance = baseChance + spell[2] - GlobalVariables.global_stats[teamFormation[i]][-1]
			var hitNumber = randi_range(0, 200)
			if hitNumber <= chance:
				GlobalVariables.global_status[teamFormation[i]] = spell[1]

func enemyTargetElementCheck(target, spell):
	var weaknessList : Array = enemies[target][1][-5]
	var resistanceList : Array = enemies[target][1][-4]
	if resistanceList.find(spell[3]):
		return 0.5
	if weaknessList.find(spell[3]):
		return 1.5
	return 1

func allyTargetElementCheck(target, spell):
	var resistanceList : Array = GlobalVariables.global_resistances[teamFormation[target-20]]
	if resistanceList.find(spell[3]):
		return 0.5
	return 1

func enemyStatusCure(target, spell):
	if enemies[target][2] == spell[1]:
		enemies[target][2] = ""
		
func allEnemiesStatusCure(spell):
	for i in range(len(enemies)):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			if enemies[i][2] == spell[1]:
				enemies[i][2] = ""

func allyStatusCure(target, spell):
	if GlobalVariables.global_status[target-20] == spell[1]:
		GlobalVariables.global_status[target-20] = ""

func allAlliesStatusCure(spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]] > 0:
			if GlobalVariables.global_status[i] == spell[1]:
				GlobalVariables.global_status[i] = ""
		
func allyAddResistance(spell, target):
	if battleResistances[teamFormation[target-20]].has(spell[3]) == false:
		battleResistances[teamFormation[target-20]].append(spell[3])

func allAlliesAddResistance(spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]] > 0:
			if battleResistances[teamFormation[i]].has(spell[3]) == false:
				battleResistances[teamFormation[i]].append(spell[3])

func enemyAddResistance(spell, target):
	if enemies[target][1][-4].has(spell[3]) == false:
		enemies[target][1][-4].append(spell[3])

func allEnemiesAddResistance(spell):
	for i in range(len(enemies)):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			if enemies[i][1][-4].has(spell[3]) == false:
				enemies[i][1][-4].append(spell[3])

func allyRemoveResistance(spell, target):
	while battleResistances[teamFormation[target-20]].has(spell[3]):
		battleResistances[teamFormation[target-20]].erase(spell[3])

func allAlliesRemoveResistance(spell):
	for i in range(4):
		if GlobalVariables.global_hp[teamFormation[i]] > 0:
			while battleResistances[teamFormation[i]].has(spell[3]):
				battleResistances[teamFormation[i]].erase(spell[3])

func enemyRemoveResistance(spell, target):
	while enemies[target][1][-4].has(spell[3]):
		enemies[target][1][-4].erase(spell[3])

func allEnemiesRemoveResistance(spell):
	for i in range(len(enemies)):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			while enemies[i][1][-4].has(spell[3]):
				enemies[i][1][-4].erase(spell[3])

func addHitMulAlly(spell, target):
	if spell[1] == 1 and hitMultiplier[GlobalVariables.team_formation[target-20]] < 2:
		hitMultiplier[GlobalVariables.team_formation[target-20]] += 1
	elif spell[1] == -1 and hitMultiplier[GlobalVariables.team_formation[target-20]] >= 1:
		hitMultiplier[GlobalVariables.team_formation[target-20]] -= 1

func addHitMulEnemy(spell, target):
	if spell[1] == 1 and enemies[target][1][3] == 1:
		enemies[target][1][3] = 2
	elif spell[1] == -1 and enemies[target][1][3] == 2:
		enemies[target][1][3] = 1

# Attack Functions
func _on_attack_pressed() -> void:
	currentAction = "AttackChoice"
	attackChoice()

func attackChoice():
	var found = false
	var i = 0
	while found == false and i != len(enemies):
		if enemies[i] != [] and enemies[i][1][0] > 0:
			if enemies[i][0] >= 62:
				get_node("enemyM_" + str(i)).grab_focus.call_deferred()
			else:
				get_node("enemyS_" + str(i)).grab_focus.call_deferred()
			found = true
		i += 1

func enemyAttack(ally, target, nbHit):
	var targetChance = [0, 0, 0, 0, 1, 1, 2, 3]
	var targets = [0, 1, 2, 3]
	var totalHits = 0
	while (totalHits != nbHit) and (len(targets) != 0):
		var targetedAlly = teamFormation[target]
		var allyHp = GlobalVariables.global_hp[targetedAlly]
		if allyHp[0] > 0:
			var status = getStatusEnemy(ally, target)
			var baseHitChance = calcBaseChance(status[0], status[1], 168, 0)
			var miss = calcMiss(baseHitChance, enemies[ally][1][2], enemies[ally][1][7])
			if miss == false:
				allyHp[0] -= enemies[ally][1][1]
				allyInfo[targetedAlly][0] += enemies[ally][1][1]
				allyCheckAlive(target)
			else:
				allyInfo[targetedAlly][1] = "MISS"
			totalHits += 1
		targets.erase(target)
		target = targetChance.pick_random()

func allyAttack(ally, target, equippedWeapon, nbHit, totalAcc, eva):
	var targets = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	var totalHits = 0
	print(nbHit)
	while (totalHits != nbHit) and (len(targets) != 0):
		if enemies[target] != [] and enemies[target][1][0] > 0:
			var weakness = isWeak(equippedWeapon, actions[ally][0])
			var status = getStatusAlly(ally, target)
			var baseHitChance = calcBaseChance(status[0], status[1], 168, weakness)
			var miss = calcMiss(baseHitChance, totalAcc, eva)
			if miss == false:
				enemies[target][1][0] -= calcAtt(equippedWeapon, ally)
				enemyInfo[target][0] += calcAtt(equippedWeapon, ally)
			else:
				enemyInfo[target][1] = "MISS"
			totalHits += 1
			if enemies[target][1][0] <= 0:
				enemies[target] = []
				dead += 1
		targets.erase(target)
		target = targets.pick_random()

func attackAction(i, customWeaponID):
	var equippedWeapon = getWeaponInfo(i, customWeaponID)
	var totalAcc = calcTotalAcc(equippedWeapon[0], i)
	var armorStats = getArmorInfo(i)
	var eva = calcEva(48, i, armorStats[1])
	var nbHit = calcNbHit(totalAcc, i)
	currentWeapon = equippedWeapon[1]
	allyAttack(i, actions[i][0], equippedWeapon[0], nbHit, totalAcc, eva)

# Aux Functions (Stats and conditions)
func getStatusAlly(attacker, target):
	var attackerStatus = GlobalVariables.global_status[teamFormation[attacker]]
	print(actions[attacker][0])
	var targetStatus = enemies[target][2]
	return [attackerStatus, targetStatus]

func getStatusEnemy(attacker, target):
	var attackerStatus = enemies[attacker][2]
	var targetStatus = GlobalVariables.global_status[teamFormation[target]]
	return [attackerStatus, targetStatus]

func isWeak(weapon: Array, target):
	if weapon == []:
		return 0
	var weaponTypes = weapon[4]
	var addedChance = 0
	var enemyType = enemies[target][1][10]
	var enemyWeak = enemies[target][1][11]
	for i in range(len(weaponTypes)):
		for j in range(len(enemyType)):
			if weaponTypes[i] == enemyType[j]:
				addedChance += 40
		for k in range(len(enemyWeak)):
			if weaponTypes[i] == enemyWeak[k]:
				addedChance += 40
	return addedChance

func calcBaseChance(attackerStatus, targetStatus, base, weakness):
	var chance = base
	if attackerStatus == "Dark":
		chance -= 40
	if targetStatus == "Dark":
		chance += 40
	return chance + weakness

func getWeaponInfo(charID, customID):
	if customID != 0:
		return [$ItemMenu.items[customID], $ItemMenu.weaponNames[customID]]
	var formation = teamFormation
	for i in range(len(GlobalVariables.global_is_equipped[formation[charID]][0])):
		if GlobalVariables.global_is_equipped[formation[charID]][0][i] == true:
			var weaponID = GlobalVariables.global_equipment_inventory[formation[charID]][0][i]
			return [$ItemMenu.items[weaponID], $ItemMenu.weaponNames[weaponID]]
	return [[], ""]

func getArmorInfo(charID):
	var armorStats = [0, 0, []]
	for i in range(len(GlobalVariables.global_is_equipped[charID][1])):
		if GlobalVariables.global_is_equipped[charID][1][i] == true:
			var armorID = GlobalVariables.global_equipment_inventory[charID][1][i]
			armorStats[0] += $ItemMenu.items[armorID][1][0]
			armorStats[1] += $ItemMenu.items[armorID][1][1]
			for j in range(len($ItemMenu.items[armorID][4])):
				armorStats[2].append($ItemMenu.items[armorID][4][j])
	return armorStats

func getAllyStats(ally):
	var stats = []
	for i in range(len(extraStats[ally])):
		if i < 2:
			stats.append(GlobalVariables.global_stats[ally][i])
		elif (i > 1 and i < 6):
			stats.append(GlobalVariables.global_stats[ally][i-2] + extraStats[ally][i])
		elif i == 7:
			stats.append(GlobalVariables.global_stats[ally][6] + extraStats[ally][i])
	print(stats)
	return stats
	
func calcTotalAcc(weapon, charID):
	var weaponAtt = 0
	var stats = getAllyStats(teamFormation[charID])
	if weapon != []:
		weaponAtt = weapon[1][1]
	return weaponAtt + stats[5]

func calcEva(baseChance, charID, armorWeight):
	var stats = getAllyStats(teamFormation[charID])
	var charAGL = stats[1]
	return baseChance + charAGL - armorWeight + extraStats[teamFormation[charID]][2]

func calcMiss(baseChance, totalAcc, eva):
	var missChance = randi_range(0, 200)
	var hitChance = (baseChance + totalAcc - eva)
	if hitChance > 200:
		hitChance = 200
	if missChance >= hitChance:
		return true
	else: return false

func calcNbHit(totalAcc, charID):
	var nbHit = (1 + int(totalAcc/32)) * hitMultiplier[charID]
	if nbHit < 1:
		nbHit = 1
	return nbHit

func calcAtt(weapon, charID):
	var stats = getAllyStats(teamFormation[charID])
	if GlobalVariables.global_allies[teamFormation[charID]] == 5:
		return GlobalVariables.global_levels[teamFormation[charID]] * 2
	var weaponAtt = 0
	if weapon != []:
		weaponAtt = weapon[1][0]
	var finalStr = int(stats[0]/2)
	return weaponAtt + finalStr + extraStats[teamFormation[charID]][1]

func allyCheckAlive(ID):
	if GlobalVariables.global_hp[teamFormation[ID]][0] <= 0:
		print(deadAllies)
		deadAllies += 1
		GlobalVariables.global_hp[teamFormation[ID]][0] = 0
		get_node("Char"+str(ID)).ko()
		get_node("Char"+str(ID)).position.x -= 4

# Info UI Functions
func showBattleUI():
	$BattleInfo.visible = true
	$EnemiesUI.z_index = -1
	$CommandUI.visible = false
	
func showInfo(characterID, actionName):
	var charName = ""
	if characterID >= 20:
		charName = GlobalVariables.global_names[teamFormation[characterID - 20]]
		infoAllyAction()
	else:
		charName = $EnemiesUI.Names[enemies[characterID][0]][1]
		infoEnemyAction()
	$BattleInfo/InfoUI_Bar/Text.text = charName + " " + str(actionName)

func hideInfo():
	for i in range(10):
		get_node("BattleInfo/InfoUI_" + str(i)).visible = false

func infoEnemyAction():
	var attackType : String = "" 
	for i in range(len(allyInfo)):
		var foundNode = get_node("BattleInfo/InfoUI_" + str(i + 6))

		if allyInfo[i][0] > 0:
			foundNode.visible = true
			attackType = changeAttackType(allyInfo[i], foundNode)
			foundNode.get_child(0).text = str(abs(allyInfo[i][0])) + attackType
		elif allyInfo[i][1] == "MISS":
			foundNode.visible = true
			foundNode.get_child(0).text = "MANQUE"
	allyInfo =  [
		[0, ""], [0, ""], [0, ""], [0, ""]
		]

func infoAllyAction():
	var foundNode : Node
	var attackType : String = "" 
	for i in range(len(enemyInfo)):
		if i >= 11:
			foundNode = get_node("BattleInfo/InfoUI_" + str(i - 8))
		elif i >= 9:
			foundNode = get_node("BattleInfo/InfoUI_" + str(i - 9))
		else:
			foundNode = get_node("BattleInfo/InfoUI_" + str(i))
			
		if enemyInfo[i][0] > 0:
			foundNode.visible = true
			attackType = changeAttackType(enemyInfo[i], foundNode)
			foundNode.get_child(0).text = str(abs(enemyInfo[i][0])) + attackType
		elif enemyInfo[i][1] == "MISS":
			foundNode.visible = true
			foundNode.get_child(0).text = "MANQUE"
	enemyInfo = [
		[0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, "", 0], [0, "", 0], [0, "", 0], 
		[0, ""], [0, ""], [0, ""], [0, ""]
		]

func changeAttackType(info, foundNode):
	if info[0] >= 0:
		return "DGT"
		foundNode.get_child(0).add_theme_color_override("default_color", Color.RED)
	else:
		return "SOIN"
		foundNode.get_child(0).add_theme_color_override("default_color", Color.GREEN)

# Timers
func _on_action_buffer_timeout() -> void:
	checkOrder()

func _on_attack_timer_timeout() -> void:
	var ID = teamFormation[charSelectedID]
	var animPlayer = $AnimationPlayer1
	$Weapon.stop()
	animPlayer.play("runback_animation_" + str(charSelectedID))
	var char = get_node("Char" + str(charSelectedID))
	char.play(char.run_name)
	attackAction(ID, actions[ID][2])
	showInfo(20+charSelectedID, getActionName(actions[ID][1]))

func _on_spell_timer_timeout() -> void:
	var ID = teamFormation[charSelectedID]
	var animPlayer = $AnimationPlayer1
	animPlayer.play("runback_animation_" + str(charSelectedID))
	var char = get_node("Char" + str(charSelectedID))
	char.play(char.run_name)
	Spells(actions[ID][0], actions[ID][1])
	showInfo(20+charSelectedID, getActionName(actions[ID][1]))
	hideAllSpellsEnemies()
	hideAllSpellsAllies()

func _on_win_timer_timeout() -> void:
	GlobalVariables.gold += totalGold
	giveExp()
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Map.tscn")

func _on_lose_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")

# Battle conclusion functions

func giveExp():
	var aliveAllies = [false, false, false, false]
	var expDivisor = 0
	for i in range(4):
		if GlobalVariables.global_hp[i][0] > 0:
			aliveAllies[i] = true
			expDivisor += 1

	var dividedExp = round(totalExp/expDivisor)
	for i in range(len(aliveAllies)):
		if aliveAllies[i]:
			GlobalVariables.global_exp[i] += dividedExp
			GlobalVariables.total_exp[i] += dividedExp
			levelUpCheck(i)

func checkNeededExp(levels, expTable, i):
	if levels[i] <= 29:
		return expTable[levels[i]+1]
	return expTable[levels[30]]

func levelUpCheck(i):
	var exp = GlobalVariables.global_exp[i]
	var levels = GlobalVariables.global_levels
	var expTable = GlobalVariables.expTable
	var neededExp = checkNeededExp(levels, expTable, i)
	while exp >= neededExp and (levels[i] != 50):
		levels[i] += 1
		GlobalVariables.global_exp[i] -= neededExp
		neededExp = checkNeededExp(levels, expTable, i)
