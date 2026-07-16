extends Node2D

signal choose_monsters(groupNum)

var enemies = [[], [], [], [], [], [], [], [], [], [], [], [], []]
var attacking = false
var moving = false

var hitMultiplier = [1, 1, 1, 1]

var existingEnemies = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var turn = 0
var turnOrder = []
var totalOrder = 0

var alive = 0
var dead = 0

var charSelectedID = 0
@onready var charSelected = GlobalVariables.team_formation[0]
var currentAction = "None"
var actions = []
var turnFinished = false

var currentWeapon = ""

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
	for i in range(0, 4):
		var char = get_node("Char" + str(i))
		char.animationCheck(formation[i])
		char.idle()
	hideCursor()
	onCharSelected()
	checkAlive()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
			actionBack()
			
	if len(actions) == 4 and turnFinished == false:
		turnFinished = true
		playTurn()

func checkAlive():
	for i in range(len(enemies)):
		if enemies[i] != []:
			if enemies[i][1][0] > 0:
				alive += 1

func actionBack():
	var formation = GlobalVariables.team_formation
	if currentAction == "None" and charSelectedID != 0:
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
			if currentAction == "Back":
				charSelectedID -= 1
				actions.pop_back()
			else:
				charSelectedID += 1
			currentAction = "None"
			charSelected = GlobalVariables.team_formation[charSelectedID]
			onCharSelected()
	else:
		if anim_name == ("run_animation_" + str(charSelectedID)):
			if (actions[charSelectedID][0] == 0):
				allyAttackAnimation()
			
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
			get_node("MagicMenu/UI/M"+str(i+1)+"_"+str(j+1)).text = $MagicMenu.Spells[spells[charSelected][i][j]][0]

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

# turn order : from 0 to 8 small enemies, 9 to 12 medium enemies, 20 to 23 allies

func playTurn():
	var foundChar = false
	hideInfo()
	showBattleUI()
	if totalOrder == 0:
		turnOrder = getTurnOrder()
	var name = ""
	while foundChar == false:
		if turnOrder != []:
			print("CURRENT TURN ORDER IS : " + str(turnOrder))
			print("TURN ORDER OF 0 : " + str(turnOrder[0]))
			if turnOrder[0] >= 20 and (GlobalVariables.global_hp[turnOrder[0] - 20][0] > 0) and (dead < alive):
					allyAction(turnOrder[0] - 20)
					name = getActionName(actions[turnOrder[0] - 20][1])
					print("Ally attacking")
					showInfo(turnOrder[0], name)
					foundChar = true
			elif turnOrder[0] < 20 and enemies[turnOrder[0]] != [] and enemies[turnOrder[0]][1][0] > 0:
					enemyAction(turnOrder[0])
					name = getActionName(0)
					print("Enemy attacking")
					showInfo(turnOrder[0], name)
					foundChar = true
		else:
			foundChar = true
		totalOrder += 1
		turnOrder.pop_front()
	
	$ActionBuffer.start()

func getActionName(actionID):
	match actionID:
		0:
			return "ATTACKS"
		_:
			return "IDK"

func showBattleUI():
	$BattleInfo.visible = true
	$EnemiesUI.z_index = -1
	$CommandUI.visible = false
	
func showInfo(characterID, actionName):
	var charName = ""
	if characterID >= 20:
		charName = GlobalVariables.global_names[GlobalVariables.team_formation[characterID - 20]]
		infoAllyAction()
	else: 
		charName = $EnemiesUI.Names[enemies[characterID][0]][1]
		infoEnemyAction()
	$BattleInfo/InfoUI_Bar/Text.text = charName + " " + str(actionName)

func hideInfo():
	for i in range(10):
		get_node("BattleInfo/InfoUI_" + str(i)).visible = false

func infoEnemyAction():
	for i in range(len(allyInfo)):
		if allyInfo[i][0] > 0:
			get_node("BattleInfo/InfoUI_" + str(i + 6)).visible = true
			get_node("BattleInfo/InfoUI_" + str(i + 6)+"/Text").text = str(allyInfo[i][0])
	allyInfo =  [
		[0, ""], [0, ""], [0, ""], [0, ""]
		]

func infoAllyAction():
	for i in range(len(enemyInfo)):
		if enemyInfo[i][0] > 0:
			if i >= 11:
				get_node("BattleInfo/InfoUI_" + str(i - 8)).visible = true
				get_node("BattleInfo/InfoUI_" + str(i - 8)+"/Text").text = str(enemyInfo[i][0])
			elif i >= 9:
				get_node("BattleInfo/InfoUI_" + str(i - 9)).visible = true
				get_node("BattleInfo/InfoUI_" + str(i - 9)+"/Text").text = str(enemyInfo[i][0])
			else:
				get_node("BattleInfo/InfoUI_" + str(i)).visible = true
				get_node("BattleInfo/InfoUI_" + str(i)+"/Text").text = str(enemyInfo[i][0])
	enemyInfo = [
		[0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], [0, ""], 
		[0, ""], [0, ""], [0, ""], [0, ""]
		]

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
	charSelectedID = i
	match actions[i][1]:
		0:
			$AnimationPlayer0.play("run_animation_" + str(i))
			var equippedWeapon = getWeaponInfo(i)
			var totalAcc = calcTotalAcc(equippedWeapon[0], i)
			var armorStats = getArmorInfo(i)
			var eva = calcEva(48, i, armorStats[1])
			var nbHit = calcNbHit(totalAcc, i)
			currentWeapon = equippedWeapon[1]
			allyAttack(i, actions[i][0], equippedWeapon[0], nbHit, totalAcc, eva)

func enemyAction(i):
	if ((enemies[i] != []) and (enemies[i][1][0] > 0)):
		var target = targetAlly()
		var nbHit = enemies[i][1][3]
		enemyAttack(i, target, nbHit)

func allyAttackAnimation():
	var animationPlayer = get_node("AnimationPlayer0")
	if currentWeapon != "":
		$Weapon.play(currentWeapon)
		animationPlayer.play("attack_animation_" + str(charSelectedID))
	get_node("Char"+str(charSelectedID)).attack()


func enemyStatusAttack(baseChance, enemy, target):
	var targetMagicDef = GlobalVariables.global_stats[GlobalVariables.team_formation[target]][6]
	var allyResistance = GlobalVariables.global_resistances[GlobalVariables.team_formation[target]]

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
			totalHits += 1
			if enemies[target][1][0] <= 0:
				enemies[target] = []
				dead += 1
		targets.erase(target)
		target = targets.pick_random()
		print(targets)
		print(target)

func enemyAttack(ally, target, nbHit):
	var targets = [0, 1, 2, 3]
	var totalHits = 0
	while (totalHits != nbHit) and (len(targets) != 0):
		var targetedAlly = GlobalVariables.team_formation[target]
		var allyHp = GlobalVariables.global_hp[targetedAlly]
		if allyHp[0] > 0:
			var status = getStatusEnemy(ally, target)
			var baseHitChance = calcBaseChance(status[0], status[1], 168, 0)
			var miss = calcMiss(baseHitChance, enemies[ally][1][2], enemies[ally][1][7])
			if miss == false:
				allyHp[0] -= enemies[ally][1][1]
				allyInfo[target][0] += enemies[ally][1][1]
			totalHits += 1
		targets.erase(target)
		target = targets.pick_random()

func getStatusAlly(attacker, target):
	var attackerStatus = GlobalVariables.global_status[GlobalVariables.team_formation[attacker]]
	print(actions[attacker][0])
	var targetStatus = enemies[target][2]
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

func calcTotalAcc(weapon, charID):
	var weaponAtt = 0
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
	if totalOrder != 17:
		playTurn()
	else:
		turnOrder = []
		totalOrder = 0
		$BattleInfo.visible = false
		$CommandUI.visible = true
		$EnemiesUI.z_index = 0
