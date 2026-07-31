extends Sprite2D

signal summon_monsters(chosenMonsters, groupMaxSize, groupSize)

func _on_choose_monsters(zoneGroups) -> void:
	var chosenGroup = getRandomGroup(zoneGroups)
	buildEnemyTeam(enemyGroups[chosenGroup])

func getRandomGroup(zoneGroups):
	var currentProbability = 0
	var randInt = randi_range(1, 64)
	for i in range(len(zoneGroups)):
		currentProbability += zoneGroups[i][1]
		if currentProbability >= randInt:
			return zoneGroups[i][0]

func buildEnemyTeam(chosenGroup):
	var enemyTeam = []
	var enemyList = []
	for i in range(len(chosenGroup)):
		enemyTeam.append(getRandomEnemies(chosenGroup[i]))
		if len(enemyTeam[i]) == 0:
			enemyTeam.pop_back()
	var formationCheck = [] 
	formationCheck = cleanEnemyTeam(enemyTeam)
	summon_monsters.emit(formationCheck[1], formationCheck[0])

func getRandomEnemies(chosenMonster):
	var enemyQuantity = randi_range(chosenMonster[1], chosenMonster[2])
	var enemyList = []
	for i in range(enemyQuantity):
		enemyList.append(chosenMonster[0])
	return enemyList

func cleanEnemyTeam(enemyList):
	var formation = 0
	var count = 0
	var cleanTeam = []
	print(enemyList)
	
	for i in range(len(enemyList)):
		print(formation)
		var cleanup = []
		cleanTeam.append(enemyList[i])
		if enemyList[i][0] < 62: 
			cleanup = indexCleanup(formation, count, cleanTeam, i, 3, 9, 1)
		else: 
			cleanup = indexCleanup(formation, count, cleanTeam, i, 1, 4, 3)
		formation = cleanup[0]
		cleanTeam = cleanup[1]
		count += len(enemyList[i])
	
		if formation == 1 and count >= 7:
			if enemyList[i][0] > 62:
				cleanTeam.pop_back()
			return [1, cleanTeam]
		elif formation == 2 and count >= 8:
			if enemyList[i][0] < 62:
				while(len(cleanTeam[i]) > 6):
					cleanTeam[i].pop_back()
			else:
				while(len(cleanTeam[i]) > 2):
					cleanTeam[i].pop_back()
			return [2, cleanTeam]
		elif formation == 3 and count >= 2:
			if enemyList[i][0] <= 62:
				cleanTeam.pop_back()
			return [3, cleanTeam]
		elif i == (len(enemyList) - 1):
			print("LA TEAAAAM : ")
			print(formation)
			print(cleanTeam)
			return [formation, cleanTeam]

func indexCleanup(formation, count, cleanTeam, i, order, max, opposite):
	if formation == order:
		if count <= 6/order:
			formation = 2
			while(len(cleanTeam[i]) > max-sqrt(max)):
				cleanTeam[i].pop_back()
		else:
			formation = order
	elif formation != 2:
		formation = opposite 
		while(len(cleanTeam[i]) > max):
			cleanTeam[i].pop_back()
	print("Formation et equipe: ")
	print(formation)
	print(cleanTeam)
	print(" ")
	return [formation, cleanTeam]
## REGLES: 
## PETITS PUIS GRANDS.
## LIMIT 6 PETITS TOTAL ET 4 GRANDS TOTAL.
	
var enemyGroups = [
	# 0 - Imps
	[[0, 5, 5], [1, 2, 2], [116, 1, 1]],
	# 1 - skelton
	[[11, 2, 4]],
	# 2 - GrIMP - wolf - grey wolf - imp
	[[1, 1, 3], [0, 0, 2], [3,0,2], [2,0,2]],
	# 3 - wolf
	[[2,1,2]],
	# 4 - zombie
	[[24,2,4]],
	# 5 - spider
	[[40,1,2]],
	# 6 - mad horse
	[[116,1,1]],
	# 7 - glisseur
	[[13,1,2]],
	# 8 - ghoul
	[[25,1,1]],
	# 9 - iguane
	[[62,1,1]],
	# 10 - shadow
	[[20,2,4]],
	# 11 - wolf - grey wolf
	[[3,2,5],[2,0,3]],
	# 12 - ogre
	[[74,1,2]],
	# 13 - cobra
	[[15,1,2]],
	# 14 - GrIMP - iguane - werewolf - gigas
	[[1,0,5],[4,1,3],[65,0,2],[62,0,2]],
	# 15- geist
	[[26,1,4]],
	# 16- gargoyle
	[[34,2,3]],
	# 17- werewolf
	[[4,3,6]],
	# 18- tarantule
	[[41,1,4]],
	# 19- ogre - green ogre
	[[74,1,2],[75,1,1]],
	# 20- tarantule
	[[41,1,4]],
	# 21 - anaconda
	[[16,2,6]],
	# 22 - cockatrice
	[[44,2,6]],
	# 23 - pede
	[[86,1,4]],
	# 24 - wraith
	[[27,2,6]],
	# 25 - tigre
	[[88,1,3]],
	# 26 - scorp
	[[18,2,4]],
	# 27 - troll - minotaur
	[[79,1,2],[77,0,1]],
	# 28 - sorcier
	[[52,2,4]],
	# 29 - momie
	[[42,2,5]],
	# 30 - gigas
	[[65,1,2]],
	# 31 - gigas - iguane
	[[65,1,2],[62,1,1]],
	# 32 - hydre
	[[105,1,2]],
	# 33 - earth
	[[90,1,1]],
	# 34 - chien enfer - ogre mage
	[[76,1,2],[73,0,1]],
	# 35 - cockatrice rouge
	[[45,2,5]],
	# 36 - hydre feu
	[[106,1,1]],
	# 37 - ochu
	[[103,1,3]],
	# 38 - gigas rouge
	[[67,1,2]],
	# 39 - fire
	[[91,1,2]],
	# 40 - ver
	[[81,1,1]],
	# 41 - agama
	[[63,1,1]],
	# 42 - dragon rouge
	[[93,1,1]],
	# 43 - skelton rouge - skelton - rampeur
	[[12,1,1],[11,2,4],[14,1,1]],
	# 44 - spectre - wraith - wight _ ghast
	[[22,1,5],[21,0,3],[27,0,3],[26,0,3]],
	# 45 - loup blanc
	[[5,3,7]],
	# 46 - gigas givre - lloup blanc
	[[67,1,1],[5,0,2]],
	# 47 - sorcier obscur
	[[58,1,4]],
	# 48 - dragon gel
	[[92,1,2]],
	# 49 - pattes vlt
	[[87,1,1]],
	# 50 - minotaur zombie
	[[78,1,3]],
	# 51 - rakshasa
	[[31,3,5]],
	# 52 - medusa
	[[28,2,5]],
	# 53 - sorcerer
	[[53,2,5]],
	# 54 - manticore
	[[96,1,3]],
	# 55 - guivre
	[[100,1,3]],
	# 56 - ankylosaur red
	[[98,1,3]],
	# 57 - tigre garou
	[[30,2,4]],
	# 58 - sauria
	[[64,1,2]],
	# 59 - chimere
	[[109,1,3]],
	# 60 - ver des sable
	[[82,1,1]],
	# 61 - allosaur
	[[101,1,1]],
	# 62 - t rex
	[[102,1,1]],
	# 63 - golem argile
	[[113,1,3]],
	# 64 - meduse vert
	[[29,1,4]],
	# 65 - neochu
	[[104,1,1]],
	# 66 - sea troll - sea scorpion
	[[19,1,3],[80,1,2]],
	# 67 - sea scorp
	[[80,2,6]],
	# 68 - sea troll - sea scorpion - sea snake
	[[19,1,6],[17,2,5],[80,2,2]],
	# 69 - prince sahag - requin blanc
	[[8,0,1],[69,1,2]],
	# 70 - sea troll - sea scorpion
	[[19,1,3],[80,1,2]],
	# 71 - death eye
	[[85,1,1]],
	# 72 - naga - water
	[[60,0,1],[107,1,1]],
	# 73 - requin blanc - yeux profon
	[[69,1,1],[71,0,1]],
	# 74 - sea troll - sea scorpion
	[[19,1,3],[80,1,2]],
	# 75 - water
	[[60,1,3]],
	# 76 - cockatrice -cockatrice rouge - mommie - roi mommie
	[[44,0,8],[45,0,8],[43,1,5],[42,0,8]],
	# 77 - dragon zombie
	[[94,1,2]],
	# 78 - gardien
	[[50,2,5]],
	# 79 - sea troll - sea scorpion
	[[19,1,3],[80,1,2]],
	# 80 - dark knight
	[[55,2,5]],
	# 81 - dragon bleu
	[[112,1,1]],
	# 82 - cauchemar
	[[117,1,3]],
	# 83 - slime noir
	[[38,3,6]],
	# 84 - vent
	[[61,2,4]],
	# 85 - vent - naga gris
	[[61,0,1,],[108,1,1]],
	# 86 - vampire sorcier
	[[33,1,3]],
	# 87 - death knight - cauchemar
	[[56,1,1],[117,1,2]],
	# 88 - chimere, gorgimere
	[[109,1,2],[110,1,2]],
	# 89 - ver violet
	[[83,1,2]],
	# 90 - golem roche
	[[114,1,2]],
	# 91 - dragon gaz
	[[111,1,1]],
	# 92 - requin - requin blanc
	[[69,1,2],[68,0,1]],
	# 93 - sahag - yeux bizar
	[[6,0,6],[70,1,2]],
	# 94 - kaizoku
	[[10,1,5]],
	# 95 - shark - sahagin - yeux bizar
	[[68,1,2],[6,0,2],[70,0,2]],
	# 96 - shark - sahag rouge
	[[7,0,1],[68,1,1]],
	# 97 - piranhna
	[[46,2,6]],
	# 98 - ochu - hydre
	[[103,0,2],[105,1,2]],
	# 99 - sea troll - sea scorpion - sea snake
	[[17,0,2],[19,0,2],[80,1,2]],
	# 100 - gator albinos - piranhna rouge
	[[47,0,3],[49,1,2]],
	# 101 - troll
	[[79,1,2]],
	# 102- minotaur
	[[77,1,2]],
	# 103- sea troll - sea scorpion
	[[19,1,3],[80,1,2]],
	# 104- ochu - hydre - piranhna - gator
	[[46,0,2],[48,0,2],[103,1,1],[105,0,1]],
	# 105- spider - tarantule - slime vert - slime gris
	[[36,0,2],[37,1,2],[40,0,2],[41,0,2]],
	# 106- tigre - tigre gris - tigre garou
	[[30,1,2],[89,0,2],[88,0,2]],
	# 107- vampire
	[[32,2,5]],
	# 108- oeil malefique
	[[84,1,1]],
	# 109- gargouille
	[[35,2,5]],
	# 110- slime gris
	[[37,1,3]],
	# 111- sorcerer
	[[53,1,3]],
	# 112- chien de l'enfer
	[[73,1,2]],
	# 113- ogre - ogre mage - hyene
	[[76,1,1],[75,1,1],[72,0,7]],
	# 114- sphinx
	[[95,1,2]],
	# 115- vouivre
	[[99,1,3]],
	# 116- ankylosaur
	[[97,1,1]],
	# 117- sea snake
	[[17,2,4]],
	# 118- imp - grimp
	[[1,0,4],[0,3,6]],
	# 119- skelton - rampeur
	[[14,0,2],[11,3,5]],
	# 120- ochu - hydre
	[[103,0,2],[105,1,2]],
	# 121- imp
	[[0,1,3]],
	# 122- wolf - grey wolf
	[[3,0,1],[2,4,6]],
	# 123- zombie - ghoul
	[[25,2,4],[24,2,3]],
	# 124- slime vert
	[[36,2,4]],
	# 125- mad horse
	[[116,2,4]],
	# 126- ogre - glisseur
	[[13,1,3],[74,1,1]],
	# 127- ghoul - geist
	[[26,0,4],[25,2,5]],
	# 128- gigas - iguane
	[[65,1,3],[62,0,2]],
	# 129- ombre
	[[20,3,7]],
	# 130- loup gris
	[[3,4,8]],
	# 131- ogre - hyene
	[[74,1,3],[72,0,2]],
	# 132- cobra
	[[15,3,7]],
	# 133- gr imp - loup gris
	[[1,2,5],[3,0,2]],
	# 134- geist - wight
	[[27,2,5],[26,2,5]],
	# 135- gargouille
	[[34,3,8]],
	# 136- loup gris - loup garou
	[[4,2,5],[3,0,5]],
	# 137- tarantule - slime rouge
	[[39,2,5],[41,0,5]],
	# 138- ogre - ogre chef
	[[75,1,4],[74,0,2]],
	# 139- tarantule
	[[41,4,8]],
	# 140- anaconda - scorpion
	[[16,2,6],[18,0,4]],
	# 141- cockatrice - mummy
	[[44,2,6],[42,1,5]],
	# 142- pede
	[[86,1,6]],
	# 143- wraith - spectre
	[[21,2,6],[22,0,4]],
	# 144- tigre - tigre gris
	[[89,1,3],[88,0,2]],
	# 145- scorpion - minotaur
	[[18,2,6],[77,1,2]],
	# 146- troll - minotaur
	[[79,1,2],[77,0,2]],
	# 147- scorpion - minotaur
	[[18,2,6],[77,1,2]],
	# 148- sorcier
	[[52,3,7]],
	# 149- roi momie - momie
	[[43,1,1],[42,3,7]],
	# 150- gigas
	[[65,2,4]],
	# 151- gigas - iguane
	[[65,1,6],[62,1,1]],
	# 152- hydre - gator
	[[105,1,4],[48,0,3]],
	# 153- terre
	[[90,2,4]],
	# 154- chien enfer - ogre mage
	[[73,1,3],[76,0,2]],
	# 155- cockatrice rouge
	[[45,4,8]],
	# 156- hydre rouge
	[[106,4,4]],
	# 157- ochu - piranhan
	[[103,1,1],[46,0,2]],
	# 158- red gigas - agama
	[[67,1,1],[63,0,3]],
	# 159- fire
	[[91,3,4]],
	# 160- ver
	[[81,2,4]],
	# 161- agama
	[[63,2,4]],
	# 162- dragon rouge
	[[93,2,4]],
	# 163- skelton rouge
	[[12,3,6]],
	# 164- spectre
	[[22,2,6]],
	# 165- loup blanc
	[[5,4,7]],
	# 166- gigas givre - loup balnc
	[[66,2,2],[5,2,6]],
	# 167- sorcier obscur - sorcier clair
	[[58,2,3],[59,1,1]],
	# 168- dragon gel
	[[92,3,4]],
	# 169- pattes pourpre
	[[87,1,2]],
	# 170- troll - minotaur zombie
	[[78,1,4],[79,0,2]],
	# 171- rekshasa - meduse
	[[31,3,7],[28,0,5]],
	# 172- medusa - tigre gris
	[[28,3,6],[89,1,2]],
	# 173- sorcerer - golem argile
	[[53,1,6],[113,1,2]],
	# 174- sphinx
	[[95,3,4]],
	# 175- guivre
	[[100,1,3]],
	# 176- red akylosaure
	[[98,1,4]],
	# 177- tigre garou - tigre gris
	[[30,3,6],[89,1,2]],
	# 178- sauria
	[[64,2,4]],
	# 179- chimere
	[[109,3,4]],
	# 180- ver des sables
	[[82,1,2]],
	# 181- allosaur - vouivre
	[[101,1,1],[99,0,1]],
	# 182- vouivre - guivre
	[[99,1,3],[100,0,5]],
	# 183- golem argile - golem roche 
	[[113,1,4],[114,1,3]],
	# 184- meduse vert
	[[29,4,7]],
	# 185- neochu
	[[104,1,2]],
	# 186- sea troll - sea scorpion
	[[80,1,2],[19,1,4]],
	# 187- sea scorpion
	[[19,3,7]],
	# 188- sea scorpion - sea snake
	[[19,1,5],[17,0,3]],
	# 189- sahag prince - requin blanc
	[[8,3,6],[69,2,2]],
	# 190- fantome
	[[23,2,5]],
	# 191- naga - eau
	[[107,1,2],[60,3,6]],
	# 192- requin blanc - yeux profon
	[[69,1,2],[71,1,2]],
	# 193- eau
	[[60,3,6],[17,0,3]],
	# 194- roi momie - momie
	[[43,1,2],[42,1,6]],
	# 195- dragon zombie
	[[94,2,4]],
	# 196- gardien - sentinelle
	[[50,0,1],[51,1,1]],
	# 197- dark knight
	[[55,5,9]],
	# 198- cauchemar - dark knight
	[[117,1,2],[55,1,2]],
	# 199- slime noir
	[[38,4,8]],
	# 200- vent
	[[61,3,6]],
	# 201- naga gris - vent
	[[108,0,1],[61,1,3]],
	# 202- vampire sorcier - dragon zombie
	[[33,1,3],[94,1,2]],
	# 203- death knight - cauchemar
	[[56,1,2],[117,1,2]],
	# 204- chimere
	[[109,1,]],
	# 205- sorcier clair
	[[59,1,2]],
	# 206- ver violet
	[[83,3,4]],
	# 207- golem roche
	[[114,2,3]],
	# 208- dragon gaz
	[[111,2,4]],
	# 209- requin blanc - requin
	[[69,1,2],[68,0,1]],
	# 210- sahag - red sahag
	[[6,3,7],[7,0,2]],
	# 211- requin
	[[68,1,1]],
	# 212- sahag
	[[6,4,6]],
	# 213- requin - red sahag
	[[68,1,2],[7,0,3]],
	# 214- piranhna
	[[46,3,8]],
	# 215- hydre - ochu
	[[105,1,1],[103,0,1]],
	# 216- requin - red sahag
	[[68,1,2],[7,0,3]],
	# 217- sea troll - sea snake
	[[80,1,1],[17,0,3]],
	# 218- gator albinos - red piranhna
	[[49,1,1],[47,1,4]],
	# 219- troll
	[[79,2,4]],
	# 220- minotaur
	[[77,2,4]],
	# 221- piranhna - gator
	[[46,2,4],[48,1,4]],
	# 222- tarantule - spider
	[[41,3,6],[40,0,2]],
	# 223- tigre garou
	[[30,4,7]],
	# 224- vampire sorcier - vampire
	[[33,1,1],[32,3,6]],
	# 225- gargouille rouge
	[[35,3,7]],
	# 226- slime gris
	[[37,4,7]],
	# 227- sorcerer
	[[37,3,7]],
	# 228- chien enfer 
	[[73,3,4]],
	# 229- ogre mage - ogre vert
	[[76,1,3],[75,0,2]],
	# 230- manticore
	[[96,1,4]],
	# 231- vouivre
	[[99,1,4]],
	# 232- ankylosaur
	[[97,1,2]],
	#233- sea snake
	[[17,3,6]],
	# 234 - sahag prince - sahag rouge
	[[8,1,2],[7,8,8]],
	# 235- golem fer
	[[115,1,2]]
]
