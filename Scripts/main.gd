extends Node2D

signal choose_monsters(groupNum)

var enemies = [[], [], [], [], [], [], [], [], [], [], [], [], []]
var attacking = false
var moving = false

var hitMultiplier = [1, 1, 1, 1]

var existingEnemies = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var turn = 0
var turnOrder = []

var charSelectedID = 0
@onready var charSelected = GlobalVariables.team_formation[0]
var currentAction = "None"
var actionableCharacter = -1
var actions = []
var turnFinished = false

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
	var formation = GlobalVariables.team_formation
	choose_monsters.emit(GlobalVariables.next_battle)
	print("The allies are : " + str(GlobalVariables.global_allies))
	for i in range(0, 4):
		var char = get_node("Char" + str(i))
		char.animationCheck(formation[i])
		char.idle()
	hideCursor()
	onCharSelected()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
			actionBack()
			
	if len(actions) == 4 and turnFinished == false:
		turnFinished = true
		playTurn()

func actionBack():
	var formation = GlobalVariables.team_formation
	if currentAction == "None" and charSelectedID != 0:
		print("Running back character of ID " + str(charSelectedID))
		currentAction = "Back"
		var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
		anPlayer.play("runback_animation_" + str(charSelectedID))
	elif currentAction == "AttackChoice":
		$CommandUI/Button.grab_focus.call_deferred()
		currentAction = "None"
	elif currentAction == "MagicChoice":
		$MagicMenu/UI.visible = false
		$CommandUI/Button.grab_focus.call_deferred()
		currentAction = "None"
	elif currentAction == "CastingSpell":
		$MagicMenu/UI/M1_1.grab_focus.call_deferred()
		currentAction = "MagicChoice"
	elif currentAction == "InventoryChoice":
		$ItemMenu/UI.visible = false
		$CommandUI/Button.grab_focus.call_deferred()

func createEnemyTeam(chosenMonsters, groupFormation, groupSize):
	print("the chosen monsters are : ")
	print(chosenMonsters)
	print("")
	var enemyCountSmall = 0
	var enemyCountMedium = 9
	var chosenCount = 0
	var totalEnemies = 0
	var maxEnemies = getMaxEnemies(groupFormation)
	print(maxEnemies)
	for i in range(len(chosenMonsters)):
		var enemyData = getEnemyData(chosenMonsters[i])
		for j in range(len(chosenMonsters[i])):
			if (totalEnemies > (maxEnemies[0] + maxEnemies[1]) ):
				print("There are already too many enemies!")
			else:
				if chosenMonsters[i][0] >= 62:
					chosenCount = enemyCountMedium
					enemyCountMedium += 1
				else: 
					chosenCount = enemyCountSmall
					enemyCountSmall += 1
				enemies[chosenCount] = [chosenMonsters[i][0], enemyData, ""]
				totalEnemies += 1
				print(totalEnemies)
	print("")
	print("")
	print(enemies)
	print("")
	print("")
	showEnemyTeam(groupFormation, maxEnemies)

func showEnemyTeam(groupFormation, maxEnemies):
	var smallCounter = 0
	var mediumCounter = 0
	var enemyCounter = 0
	var enemyName = "enemyS_"
	var max = maxEnemies[0]
	changeFormation(groupFormation)
	print("The formation is : " + str(groupFormation))
	print(enemies)
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
				print("Showed " + enemyName + str(enemyCounter))
				enemy.texture_normal = load(enemies[i][1][15])
				enemyCounter += 1
			else: print("Maximum amount of " + enemyName + " reached.")
	changeFormationFocus(groupFormation)

func getMaxEnemies(groupFormation):
	match groupFormation:
		1: return [9, 0]
		2: return [6, 2]
		3: return [0, 4]

func getEnemyData(chosenMonster):
	var EnemyList = $Battle_UI.Monsters
	var enemyData = EnemyList[chosenMonster[0]]
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

func changeFocus():
	pass

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

func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	print("yes")
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 10, get_node(extra_arg_0).position.y + 19)

func _on_enemy_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x, get_node(extra_arg_0).position.y + 19)

func onCharSelected():
	var char : AnimatedSprite2D = get_node("Char" + str(charSelectedID))
	var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
	char.play(char.run_name)
	anPlayer.play("run_animation_" + str(charSelectedID))

func _on_attack_pressed() -> void:
	currentAction = "AttackChoice"
	attackChoice()

func hideCursor():
	$HandCursor.visible = false

func showCursor():
	$HandCursor.visible = true

func attackChoice():
	if $enemyM_0.is_visible_in_tree():
		$enemyM_0.grab_focus.call_deferred()
	else:
		$enemyS_0.grab_focus.call_deferred()

func _on_animation_finished_char0(anim_name: StringName) -> void:
	var char : AnimatedSprite2D = get_node("Char" + str(charSelectedID))
	char.play(char.idle_name)
	if turnFinished == false:
		if anim_name == ("run_animation_" + str(charSelectedID)):
			showCursor()
			$CommandUI/Button.grab_focus.call_deferred()
		if anim_name == ("runback_animation_" + str(charSelectedID)):
			print("Going to next character")
			print(currentAction)
			if currentAction == "Back":
				print("Next character is previous character")
				charSelectedID -= 1
				actions.pop_back()
			else:
				print("Next character is not previous character")
				charSelectedID += 1
			currentAction = "None"
			charSelected = GlobalVariables.team_formation[charSelectedID]
			print(charSelectedID)
			onCharSelected()
			
func _on_enemy_pressed(extra_arg_0: int) -> void:
	if currentAction == "CastingSpell":
		actions.append([extra_arg_0, currentSpell])
	else:
		actions.append([extra_arg_0, 0])
	if $MagicMenu/UI.visible == true:
		$MagicMenu/UI.visible = false
	$HandCursor.visible = false
	get_viewport().gui_release_focus()
	currentAction = "None"
	var char = get_node("Char" + str(charSelectedID))
	var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
	anPlayer.play("runback_animation_" + str(charSelectedID))
	char.play(char.run_name)
	print(actions)

func _on_magic_pressed() -> void:
	currentAction = "MagicChoice"
	magicChoice()

func magicChoice():
	$MagicMenu/UI.visible = true
	$MagicMenu/UI/M1_1.grab_focus.call_deferred()
	showSpells()

func _on_spell_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 5, get_node(extra_arg_0).position.y + 23)

func showSpells():
	var spells = GlobalVariables.global_spells
	for i in range((len(spells[charSelected]))):
		for j in range((len(spells[charSelected][0]))):
			print(get_node("MagicMenu/UI/M"+str(i+1)+"_"+str(j+1)))
			get_node("MagicMenu/UI/M"+str(i+1)+"_"+str(j+1)).text = $MagicMenu.Spells[spells[charSelected][i][j]][0]
			print($MagicMenu.Spells[spells[charSelected][i][j]][0])

func _on_spell_pressed(extra_arg_0: Array) -> void:
	var spellID = GlobalVariables.global_spells[charSelected][extra_arg_0[0]][extra_arg_0[1]]
	var spell = $MagicMenu.Spells[spellID]
	spellTarget(spell, spellID)
	
func spellTarget(spell, spellID):
	var target_type = spell[4]
	currentSpell = spellID
	if target_type != "R":
		currentAction = "CastingSpell"
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
						actions.append([-1, spellID])
					"AA":
						actions.append([-2, spellID])
					"C":
						actions.append([-3, spellID])
				currentAction = "None"
				$MagicMenu/UI.visible = false
				$HandCursor.visible = false
				get_viewport().gui_release_focus()
				var char = get_node("Char" + str(charSelectedID))
				var anPlayer : AnimationPlayer = get_node("AnimationPlayer0")
				anPlayer.play("runback_animation_" + str(charSelectedID))
				char.play(char.run_name)

func _on_char_focus_entered(extra_arg_0: NodePath) -> void:
		$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 16, get_node(extra_arg_0).position.y)

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

func getTurnOrder():
	var enemylist = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	var allylist = [20, 21, 22, 23]
	var order = [] 	
	while len(order) != 17:
		print(len(enemylist))
		print(allylist)
		if randi_range(0, 1) == 0 and len(enemylist) != 0: 
			order = getRandomCharacter(enemylist, order)
		elif len(allylist) != 0: 
			order = getRandomCharacter(allylist, order)
		else: 
			return order

func getRandomCharacter(list: Array, order: Array):
	var choix = randi_range(0, len(list) - 1)
	order.append(choix)
	list.pop_at(choix)
	return order

# turn order : from 0 to 8 small enemies, 9 to 12 medium enemies, 20 to 23 allies

func playTurn():
	allyAction(0)
	name = getActionName(actions[0][1])
	showInfo(20, name)
	#turnOrder = getTurnOrder()
	#var name = ""
	#if turnOrder[0] >= 20:
	#	actionableCharacter = turnOrder[0] - 20
	#	allyAction(turnOrder[0])
	#	name = getActionName(actions[turnOrder[0]][1])
	#else:
	#	enemyAction(turnOrder[0])
	#	name = getActionName(0)
	#turnOrder.pop_front()
	#if len(turnOrder) != 0:
	#	$ActionBuffer.start()

func getActionName(actionID):
	match actionID:
		0: 
			return "ATTACKS"
		_:
			return "IDK"
	

func showInfo(characterID, actionName):
	$BattleInfo.visible = true
	$EnemiesUI.z_index = -1
	$CommandUI.visible = false
	var charName = ""
	if characterID >= 20:
		charName = GlobalVariables.global_names[GlobalVariables.team_formation[characterID - 20]]
		infoAllyAction()
	else: 
		charName = $EnemiesUI.Names[enemies[characterID][0]]
		infoEnemyAction()
	$BattleInfo/InfoUI_Bar/Text.text = charName + " " + actionName

func infoEnemyAction():
	pass
	
func infoAllyAction():
	for i in range(len(allyInfo)):
		if enemyInfo[i][0] > 0:
			if i >= 11:
				get_node("BattleInfo/InfoUI_" + str(i - 8)).visible = true
			elif i >= 9:
				get_node("BattleInfo/InfoUI_" + str(i - 9)).visible = true
			else:
				get_node("BattleInfo/InfoUI_" + str(i)).visible = true
func targetAlly():
	var randAlly = randi_range(1, 8)
	if randAlly <= 4:
		return 0
	elif randAlly <= 6:
		return 1
	elif randAlly == 7:
		return 2
	else: return 3

func allyAction(i):
	match actions[i][1]:
		0:
			var storedHits = []
			var equippedWeapon = getWeaponInfo(i)
			var totalAcc = calcTotalAcc(equippedWeapon, i)
			var armorStats = getArmorInfo(i)
			var eva = calcEva(48, i, armorStats[1])
			var nbHit = calcNbHit(totalAcc, i)
			for j in range(nbHit):
				var weakness = isWeak(equippedWeapon, actions[i][0])
				var status = getStatusAlly(i)
				var baseHitChance = calcBaseChance(status[0], status[1], 168, weakness)
				var miss = calcMiss(baseHitChance, totalAcc, eva)
				if miss == true:
					print("Character missed")
				else:
					storedHits.append(calcAtt(equippedWeapon, i))
			allyAttack(storedHits, actions[i][0])
			print(enemyInfo)

func enemyAction(i):
	var target = targetAlly()
	var storedHits = []
	var nbHit = enemies[i][1][3]
	for j in range(nbHit):
		var status = getStatusEnemy(i, target)
		var baseHitChance = calcBaseChance(status[0], status[1], 168, 0)
		var miss = calcMiss(baseHitChance, enemies[i][1][2], enemies[i][1][7])
		if miss == true:
			print("Enemy missed")
		else:
			print(enemies[i])
			print(enemies[i][1][0])
			storedHits.append(enemies[i][1][1])
	enemyAttack(storedHits, target)
	print(storedHits)
	print(allyInfo)

func getNewAlly():
	var targets = [0, 1, 2, 3]
	var newTarget = randi_range(0, 3)
	if GlobalVariables.global_hp[GlobalVariables.team_formation[newTarget]][0] <= 0:
		while GlobalVariables.global_hp[GlobalVariables.team_formation[newTarget]][0] <= 0:
			print("Ally is already dead, searching for new ally")
			targets.pop_at(newTarget)
			newTarget = randfn(0, len(targets))
			if targets == []:
				print("no ally alive left")
				return -1
	return targets[newTarget]

func enemyStatusAttack(baseChance, enemy, target):
	var targetMagicDef = GlobalVariables.global_stats[GlobalVariables.team_formation[target]][6]
	var allyResistance = GlobalVariables.global_resistances[GlobalVariables.team_formation[target]]

func allyAttack(hits, target):
	for i in range(len(hits)):
		if enemies[target][1][0] <= 0:
			print("target is already dead, searching for new target")
			target = getNewEnemy()
			if target != -1:
				enemies[target][1][0] -= hits[i]
				enemyInfo[target][0] += hits[i]
		else:
			enemies[target][1][0] -= hits[i]
			enemyInfo[target][0] += hits[i]

func enemyAttack(hits, target):
	for i in range(len(hits)):
		var targetedAlly = GlobalVariables.team_formation[target]
		var allyHp = GlobalVariables.global_hp[targetedAlly]
		if allyHp[0] <= 0:
			print("target is already dead, searching for new target")
			target = getNewAlly()
			if target != -1:
				allyHp[0] -= hits[i]
				allyInfo[target][0] += hits[i]
		else:
			allyHp[0] -= hits[i]
			allyInfo[target][0] += hits[i]

func getNewEnemy():
	var targets = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
	var newTarget = randi_range(0, 12)
	if enemies[newTarget] == [] or enemies[newTarget][1][0] <= 0:
		while enemies[newTarget] == [] or enemies[newTarget][1][0] <= 0:
			print("target is already dead, searching for new target")
			targets.pop_at(newTarget)
			print("New target is : " + str(newTarget))
			newTarget = randi_range(0, len(targets))
			if targets == []:
				print("no target left found")
				return -1
	return targets[newTarget]

func getStatusAlly(attacker):
	var attackerStatus = GlobalVariables.global_status[GlobalVariables.team_formation[attacker]]
	var targetStatus = enemies[actions[attacker][0]][2]
	return [attackerStatus, targetStatus]

func getStatusEnemy(attacker, target):
	var attackerStatus = enemies[attacker][2]
	var targetStatus = GlobalVariables.global_status[GlobalVariables.team_formation[target]]
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

func getWeaponInfo(charID):
	var formation = GlobalVariables.team_formation
	for i in range(len(GlobalVariables.global_is_equipped[formation[charID]][0])):
		if GlobalVariables.global_is_equipped[formation[charID]][0][i] == true:
			var weaponID = GlobalVariables.global_equipment_inventory[formation[charID]][0][i]
			return $ItemMenu.items[weaponID]
	return []

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

func calcTotalAcc(weapon, charID):
	var weaponAtt = 0
	print(weapon)
	print(charID)
	if weapon != []:
		weaponAtt = weapon[1][1]
	return weaponAtt + GlobalVariables.global_stats[GlobalVariables.team_formation[charID]][5]

func calcEva(baseChance, charID, armorWeight):
	var charAGL = GlobalVariables.global_stats[GlobalVariables.team_formation[charID]][1]
	return baseChance + charAGL - armorWeight

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
	print("Character is going to hit " + str(nbHit) + " times.")
	return nbHit

func calcAtt(weapon, charID):
	if GlobalVariables.global_allies[GlobalVariables.team_formation[charID]] == 5:
		return GlobalVariables.global_levels[GlobalVariables.team_formation[charID]] * 2
	var weaponAtt = 0
	if weapon != []:
		weaponAtt = weapon[1][0]
	var finalStr = int(GlobalVariables.global_stats[GlobalVariables.team_formation[charID]][0]/2)
	return weaponAtt + finalStr


func _on_action_buffer_timeout() -> void:
	pass
