extends Node
# HP/ATK/ACC/NHIT/CRT/DEF/EVA/MDEF/MOR/SATK/EATK/TYPE/WEAK/REST/GOLD/EXP/IMGPATH

var Monsters = [
	#IMP 0
	[8, 4, 2, 1, 1, 4, 6, 16, 106, ["None"],["None"],["None"],["None"],["None"], 6, 6,"res://Sprites/Enemies/Small/imp.png"]
	,#GrIMP 1
	[16, 8, 4, 1, 1, 6, 9, 23, 120, ["None"],["None"],["None"],["None"],["None"], 18, 18,"res://Sprites/Enemies/Small/grImp.png"]
	,#WOLF 2
	[20, 8, 5, 1, 1, 0, 36, 28, 105, ["None"],["None"], ["Beast"], ["None"], ["None"], 6, 24,"res://Sprites/Enemies/Small/loup.png"]
	,#GrWOLF 3
	[72, 14, 18, 1, 1, 0, 54, 46, 108, ["None"],["None"], ["Beast"], ["None"], ["None"], 22, 93,"res://Sprites/Enemies/Small/grloup.png"]
	,#WrWolf 4
	[68, 14, 17, 1, 1, 6, 42, 45, 120, ["None"],["None"], ["Beast"], ["None"], ["None"], 67, 135,"res://Sprites/Enemies/Small/loupgarou.png"]
	,#FrWolf 5
	[92, 25, 23, 1, 1, 0, 54, 55, 105, ["None"],["None"], ["Beast"], ["Fire"], ["Ice"], 200, 402,"res://Sprites/Enemies/Small/loupgblanc.png"]
	,#Sahag 6
	[28, 10, 7, 1, 1, 4, 72, 28, 110, ["None"],["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 30, 30,"res://Sprites/Enemies/Small/sahagin.png"]
	,#RSahag 7
	[64, 15, 16, 1, 1, 8, 78, 46, 142, ["None"],["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 105, 105,"res://Sprites/Enemies/Small/sahaginr.png"]
	,#WzSahag 8
	[204, 47, 51, 1, 1, 20, 96, 101, 101, ["None"],["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 882, 882,"res://Sprites/Enemies/Small/sahaginpr.png"]
	,#pirate 9
	[6, 8, 2, 1, 1, 0, 12, 15, 255, ["None"],["None"],["None"],["None"],["None"], 40, 40,"res://Sprites/Enemies/Small/pirate.jpg"]
	,#Kyzoku 10
	[50, 14, 13, 1, 1, 6, 24, 37, 106, ["None"],["None"], ["None"], ["None"], ["Earth"], 120, 60,"res://Sprites/Enemies/Small/kaizuko.png"]
	,#bone 11
	[10, 10, 2, 1, 1, 0, 12, 17, 124, ["None"],["None"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 3, 9,"res://Sprites/Enemies/Small/skelton.png"]
	,#RBone 12
	[144, 26, 36, 1, 1, 12, 42, 76, 156, ["None"],["None"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 378, 378,"res://Sprites/Enemies/Small/skeltonrge.png"]
	,#Creep 13
	[56, 17, 14, 1, 1, 8, 24, 40, 104, ["None"],["None"], ["None"], ["Fire"], ["None"], 15, 63,"res://Sprites/Enemies/Small/glisse.png"]
	,#Crawl 14
	[84, 1, 21, 8, 1, 8, 42, 51, 106, ["Para"],["Status"], ["None"], ["None"], ["None"], 200, 186,"res://Sprites/Enemies/Small/rampe.png"]
	,#asp 15
	[56, 6, 14, 1, 1, 6,30, 46, 107, ["Psn"], ["Psn"], ["None"], ["None"], ["None"], 50, 123,"res://Sprites/Enemies/Small/cobra.png"]
	,#cobra 16
	[80, 22, 20, 1, 31, 10, 36, 56, 110, ["None"],["None"],["None"],["None"],["None"], 50, 165,"res://Sprites/Enemies/Small/anaconda.png"]
	,#seasnake 17
	[224, 35, 56, 1, 0, 12, 48, 116, 200, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 600, 957,"res://Sprites/Enemies/Small/aquaserpent.png"]
	,#scorpion 18
	[84, 22, 21, 2, 1, 10, 54, 55, 112, ["Psn"], ["Psn"],["None"], ["None"], ["None"], ["None"], 70, 225,"res://Sprites/Enemies/Small/scorp.png"]
	,#Lobster 19
	[148, 35, 37, 3, 1, 18, 60, 85, 200, ["Psn"], ["Psn"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 300, 639,"res://Sprites/Enemies/Small/seascorp.png"]
	,#shadow 20
	[50, 10, 13, 1, 1, 0, 36, 37, 124, ["Dark"],["Status"],["None"], ["Mage","Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 45, 90,"res://Sprites/Enemies/Small/ombre.png"]
	,#wraith 21
	[86, 22, 22, 1, 1, 4, 90, 52, 160, ["Para"],["Status"],["None"], ["Mage","Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 231, 231,"res://Sprites/Enemies/Small/wraith.png"]
	,#spectre 22
	[114, 40, 29, 1, 1, 12, 108, 67, 160, ["Para"],["Status"],["None"], ["Mage","Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 432, 432,"res://Sprites/Enemies/Small/spectre.png"]
	,#ghost 23
	[180, 93, 45, 1, 1, 30, 36, 85, 184, ["Para"],["Status"],["None"], ["Mage","Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 990, 990,"res://Sprites/Enemies/Small/Fantome.png"]
	,#zombie 24
	[20, 10, 5, 1, 1, 0, 6, 25, 120, ["None"],["None"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 12, 24,"res://Sprites/Enemies/Small/zombie.png"]
	,#ghoul 25
	[48, 8, 12, 3, 1, 6, 12, 36, 124, ["Para"],["Status"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 50, 93,"res://Sprites/Enemies/Small/ghoul.png"]
	,#geist 26
	[56, 8, 12, 3, 1, 10, 46, 40, 160, ["Para"],["Status"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 117, 117,"res://Sprites/Enemies/Small/gheist.png"]
	,#wight 27
	[52, 20, 13, 1, 1, 12, 42, 45, 160, ["None"],["None"],["None"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 150, 150,"res://Sprites/Enemies/Small/wight.png"]
	,#medusa 28
	[68, 20, 17, 1, 1, 10, 36, 55, 150, ["Psn"], ["Psn"], ["None"], ["None"], ["None"], 699, 699,"res://Sprites/Enemies/Small/Meduse.png"]
	,#grmedusa 29
	[96, 11, 24, 10, 1, 12, 72, 70, 200, ["Para"],["Status"], ["None"], ["None"], ["None"], 1218, 1218,"res://Sprites/Enemies/Small/Meduse vert.png"]
	,#catman 30 
	[160, 30, 40, 2, 1, 16, 48, 93, 148, ["Psn"], ["Psn"], ["Beast"], ["None"], ["None"], 780, 780,"res://Sprites/Enemies/Small/tigre garou.png"]
	,#mancat 31
	[110, 20, 28, 3, 1, 30, 60, 62, 150, ["None"],["None"], ["Beast"], ["None"], ["Status","Psn","Stn","Death","Fire","Ice","Thdr","Earth"], 699, 699,"res://Sprites/Enemies/Small/tigre vert.png"]
	,#vampire 32 
	[156, 76, 39, 1, 1, 24, 72, 75, 200, ["Para"],["Status"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 2000, 1200,"res://Sprites/Enemies/Small/vamp.png"]
	,#wzvamp 33
	[300, 90, 42, 1, 1, 28, 72, 84, 200, ["Para"],["Status"], ["Mage","Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 3000, 2385,"res://Sprites/Enemies/Small/vampmage.png"]
	,#gargoyle 34
	[80, 12, 20, 4, 1, 8, 45, 53, 132, ["None"],["None"], ["None"], ["None"], ["Earth"], 80, 132, "res://Sprites/Enemies/Small/gargoyle.png"]
	,#rgoyle 35 
	[94, 10, 24, 4, 1, 32, 72, 127, 134, ["Stn"],["Stn"], ["None"], ["None"], ["Fire","Ice","Earth"], 387, 387,"res://Sprites/Enemies/Small/redgargoyle.png"]
	,#scum 36
	[24, 1, 1, 1, 1, 255, 0, 36, 124, ["Psn"], ["Psn"], ["None"], ["Fire","Ice"], ["Status","Psn","Stn","Death","Thdr","Earth"], 20, 84,"res://Sprites/Enemies/Small/slime vert.png"]
	,#muck 37
	[76, 30, 19, 1, 1, 7, 4, 55, 152, ["None"],["None"], ["None"], ["Thdr"], ["Status","Psn","Stn","Death","Fire","Ice","Earth"], 70, 255,"res://Sprites/Enemies/Small/slime gris.png"]
	,#ooze 38
	[76, 32, 19, 1, 1, 6, 6, 55, 144, ["None"],["None"], ["None"], ["Fire","Ice"], ["Status","Psn","Stn","Death","Thdr","Earth"], 70, 252,"res://Sprites/Enemies/Small/slime rouge.png"]
	,#slime 39
	[156, 49, 39, 1, 1, 255, 24, 85, 200, ["Psn"], ["Psn"], ["None"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Thdr","Earth"], 900, 1101,"res://Sprites/Enemies/Small/slime noir.png"]
	,#spider 40
	[28, 10, 7, 1, 1, 0, 30, 28, 109, ["None"],["None"],["None"],["None"],["None"], 8, 30,"res://Sprites/Enemies/Small/spidr.png"]
	,#arachnid 41
	[64, 5, 16, 1, 1, 12, 24, 46, 111, ["Psn"], ["None"], ["None"], ["None"], 50, 141,"res://Sprites/Enemies/Small/spidr2.png"]
	,#mummy 42
	[80, 30, 20, 1, 1, 20, 24, 60, 172, ["Sleep"],["Status"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 300, 300,"res://Sprites/Enemies/Small/mommie.png"]
	,#wzmummy 43
	[188, 43, 47, 1, 1, 24, 24, 95, 148, ["Sleep"],["Status"], ["Undead"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 1000, 984,"res://Sprites/Enemies/Small/roimommie.png"]
	,#coctrice 44 
	[50, 1, 10, 1, 1, 4, 72, 47, 124, ["Stn"],["Stn"], ["None"], ["None"], ["Earth"], 200, 186,"res://Sprites/Enemies/Small/cocatrice.png"]
	,#perilisk 45
	[44, 20, 11, 1, 1, 4, 72, 45, 124, ["None"],["None"], ["None"], ["Ice"], ["Fire","Earth"], 200, 186,"res://Sprites/Enemies/Small/redcocatrice.png"]
	,#caribe 46
	[92, 22, 23, 1, 1, 0, 72, 68, 138, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 20, 240,"res://Sprites/Enemies/Small/piranhna.png"]
	,#redcaribe 47
	[172, 37, 43, 1, 1, 20, 72, 83, 142, ["None"],["None"], ["Aqua"], ["None"], ["None"], 46, 546,"res://Sprites/Enemies/Small/redpiranhna.png"]
	,#gator 48
	[184, 42, 46, 2, 1, 16, 48, 103, 138, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 900, 816,"res://Sprites/Enemies/Small/gator.png"]
	,#frgator 49
	[288, 56, 72, 2, 1, 20, 48, 143, 142, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 2000, 1890,"res://Sprites/Enemies/Small/gator albinos.png"]
	,#guard 50
	[200, 25, 50, 2, 1, 40, 72, 110, 200, ["Para"],["Status"], ["None"], ["Thdr"], ["Status","Psn","Stn","Death"], 400, 1224,"res://Sprites/Enemies/Small/gardien.png"]
	,#sentry 51
	[400, 102, 90, 1, 1, 48, 96, 160, 150, ["None"],["None"], ["None"], ["Thdr"], ["Status","Psn","Stn","Death","Fire","Ice","Earth"], 2000, 4000,"res://Sprites/Enemies/Small/sentry.png"]
	,#wizard 52
	[84, 30, 21, 2, 1, 16, 66, 98, 126, ["None"],["None"], ["Mage"], ["None"], "FirIceStatu(exEarth&Time&Death)", 300, 276,"res://Sprites/Enemies/Small/sorcier.png"]
	,#sorcerer 53
	[112, 1, 28, 3, 1, 12, 48, 187, 130, ["Death"], ["Death"], ["Mage"], ["None"], ["None"], 999, 822,"res://Sprites/Enemies/Small/sorcerer.png"]
	,#garland 54
	[106, 15, 27, 1, 1, 10, 12, 64, 255, ["None"],["None"],["None"],["None"],["None"], 250, 130,"res://Sprites/Enemies/Small/garland.png"]
	,#badman 55
	[260, 44, 65, 2, 1, 38, 36, 135, 200, ["None"],["None"],["None"],["None"],["None"], 1800, 1263,"res://Sprites/Enemies/Small/dark knight.png"]
	,#evilman 56
	[190, 55, 48, 1, 1, 32, 42, 173, 200, ["None"],["None"], ["Mage"], ["None"], ["Status","Psn","Stn","Death"], 3000, 2700,"res://Sprites/Enemies/Small/death knight.png"]
	,#astos 57
	[168, 26, 42, 1, 1, 40, 78, 170, 255, ["None"],["None"], ["Mage"], ["None"], ["None"], 2000, 2250,"res://Sprites/Enemies/Small/astos.png"]
	,#mage 58
	[105, 26, 27, 1, 1, 40, 78, 170, 200, ["None"],["None"], ["Mage"], ["None"], ["None"], 1095, 1095,"res://Sprites/Enemies/Small/sorcier sombre.png"]
	,#fighter 59
	[200, 40, 45, 1, 1, 38, 90, 186, 158, ["None"],["None"], ["Mage"], ["None"], ["None"], 3420, 3420,"res://Sprites/Enemies/Small/sorcier clair.png"]
	,#water 60
	[300, 69, 68, 1, 1, 20, 72, 130, 200, ["None"],["None"], ["None"], ["Ice"], ["Status","Psn","Stn","Death","Fire","Earth"], 800, 1962,"res://Sprites/Enemies/Small/eau.png"]
	,#air 61
	[358, 53, 62, 1, 1, 4, 144, 130, 200, ["None"],["None"], ["None"], ["None"], ["Status","Psn","Stn","Death","Earth"], 807, 1614,"res://Sprites/Enemies/Small/air.png"]
	,#Iguana 62 - MEDIUM START
	[92, 18, 23, 1, 10, 12, 24, 55, 134, ["None"],["None"],["None"],["None"],["None"], 50, 153,"res://Sprites/Enemies/Medium/iguane.png"]
	,#Agama 63
	[296, 31, 74, 2, 1, 18, 36, 143, 200, ["None"],["None"], ["None"], ["Ice"], ["Fire"], 1200, 2472,"res://Sprites/Enemies/Medium/agama.png"]
	,#Sauria 6
	[196, 30, 54, 1, 1, 20, 24, 91, 200, ["None"],["None"],["None"],["None"],["None"], 658, 1977,"res://Sprites/Enemies/Medium/sauria.png"]
	,#Giant 65
	[240, 38, 0, 1, 1, 12, 48, 120, 136, ["None"],["None"], ["Giant"], ["None"], ["None"], 879, 879,"res://Sprites/Enemies/Medium/gigas.png"]
	,#FrGiant 66
	[336, 60, 78, 1, 1, 16, 8, 150, 200, ["None"],["None"], ["Giant"], ["Fire"], ["Ice"], 1752, 1752,"res://Sprites/Enemies/Medium/gigas blanc.png"]
	,#RGiant 67
	[300, 73, 83, 1, 1, 20, 48, 135, 200, ["None"],["None"], ["Giant"], ["Ice"], ["Fire"], 1506, 1506,"res://Sprites/Enemies/Medium/gigas rouge.png"]
	,#Shark 68
	[120, 22, 30, 1, 1, 0, 72, 70, 121, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 66, 267,"res://Sprites/Enemies/Medium/requin.png"]
	,#GrShark 69
	[344, 50, 86, 1, 1, 8, 72, 170, 200, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 600, 2361,"res://Sprites/Enemies/Medium/requinblanc.png"]
	,#OddEYE 70
	[10, 4, 2, 1, 1, 0, 84, 14, 110, ["None"],["None"], ["None"], ["Thdr"], ["Fire","Earth"], 10, 42,"res://Sprites/Enemies/Medium/yeux bizar.png"]
	,#bigeye 71
	[304, 30, 76, 2, 1, 16, 24, 156, 200, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 3591, 3591,"res://Sprites/Enemies/Medium/yeux profon.png"]
	,#Hyena 72
	[120, 22, 30, 8, 1, 4, 48, 76, 122, ["None"],["None"], ["Beast"], ["None"], ["None"], 72, 288,"res://Sprites/Enemies/Medium/hyene.png"]
	,#cerebus 73
	[192, 30, 48, 1, 1, 8, 48, 106, 146, ["None"],["None"], ["Beast"], ["Ice"], ["Fire"], 600, 1182,"res://Sprites/Enemies/Medium/chien enfer.png"]
	,#ogre 74
	[100, 18, 25, 1, 1, 10, 18, 65, 116, ["None"],["None"], ["Giant"], ["None"], ["None"], 195, 195,"res://Sprites/Enemies/Medium/ogre.png"]
	,#Grogre 75
	[132, 23, 33, 1, 1, 14, 30, 71, 126, ["None"],["None"], ["Giant"], ["None"], ["None"], 300, 282,"res://Sprites/Enemies/Medium/ogre vert.png"]
	,#Wzorgre 76
	[144, 23, 36, 1, 1, 10, 54, 80, 134, ["None"],["None"], ["Mage","Giant"], ["None"], ["Earth"], 723, 723,"res://Sprites/Enemies/Medium/ogre mage.png"]
	,#bull 77
	[164, 22, 41, 2, 1, 4, 48, 95, 124, ["None"],["None"], ["Giant"], ["None"], ["None"], 489, 489,"res://Sprites/Enemies/Medium/minotaur.png"]
	,#Zombull 78
	[224, 40, 56, 1, 1, 14, 36, 116, 136, ["None"],["None"], ["Undead","Giant"], ["Fire"], ["Status","Psn","Stn","Death","Ice"], 1050, 1050,"res://Sprites/Enemies/Medium/minotaurzombie.png"]
	,#troll 79
	[184, 24, 46, 3, 1, 12, 48, 100, 136, ["None"],["None"], ["Giant"], ["Fire"], ["None"], 621, 621,"res://Sprites/Enemies/Medium/troll.png"]
	,#seatroll 80
	[216, 40, 54, 1, 1, 20, 48, 110, 200, ["None"],["None"], ["Aqua","Giant"], ["Thdr"], ["Earth"], 852, 852,"res://Sprites/Enemies/Medium/seatroll.png"]
	,#worm 81
	[448, 65, 112, 1, 10, 10, 36, 200, 200, ["None"],["None"], ["None"], ["None"], ["Earth"], 1000, 4344,"res://Sprites/Enemies/Medium/ver.png"]
	,#sandworm 82
	[200, 46, 50, 1, 1, 14, 62, 103, 124, ["None"],["None"], ["None"], ["None"], ["Earth"], 900, 2683,"res://Sprites/Enemies/Medium/ver des sables.png"]
	,#greyworm 83
	[280, 50, 70, 1, 1, 31, 4, 143, 200, ["None"],["None"], ["None"], ["Ice"], ["Fire","Earth"], 400, 1671,"res://Sprites/Enemies/Medium/ver violet.png"]
	,#eye 84
	[162, 30, 42, 1, 1, 30, 12, 92, 200, ["None"],["None"], ["Mage"], ["None"], ["Earth"], 3225, 3225,"res://Sprites/Enemies/Medium/oeil malefique.png"]
	,#phantom 85
	[360, 120, 150, 1, 40, 60, 24, 160, 200, ["Para"],["Status"], ["Mage","Undead"], ["None"], ["Earth"], 1, 1,"res://Sprites/Enemies/Medium/oeil fatale.png"]
	,#pede 86
	[222, 39, 56, 1, 1, 20, 48, 116, 111, ["Psn"], ["Psn"], ["None"], ["None"], ["None"], 300, 1194,"res://Sprites/Enemies/Medium/pede.png"]
	,#grpede 87
	[320, 73, 80, 1, 1, 24, 48, 185, 176, ["None"],["None"], ["None"], ["None"], ["Fire","Ice"], 1000, 2244,"res://Sprites/Enemies/Medium/pede vert.png"]
	,#tiger 88
	[132, 22, 33, 2, 25, 8, 48, 85, 116, ["None"],["None"], ["Beast"], ["None"], ["None"], 108, 438,"res://Sprites/Enemies/Medium/tigre .png"]
	,#sabretiger 89
	[200, 24, 50, 2, 70, 8, 42, 106, 180, ["None"],["None"], ["Beast"], ["None"], ["None"], 500, 838,"res://Sprites/Enemies/Medium/tigre gris.png"]
	,#earth 90
	[288, 66, 72, 1, 1, 20, 18, 130, 200, ["None"],["None"], ["Mage"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Thdr","Earth"], 768, 1536,"res://Sprites/Enemies/Medium/terre.png"]
	,#fire 91
	[276, 50, 69, 1, 1, 20, 42, 130, 200, ["None"],["None"], ["Mage"], ["Ice"], ["Status","Psn","Stn","Death","Fire","Earth"], 800, 1620,"res://Sprites/Enemies/Medium/feu.png"]
	,#frostdrag 92
	[200, 53, 50, 1, 1, 8, 120, 196, 200, ["None"],["None"], ["Dragon"], ["Fire","Thdr"], ["Psn","Stn","Ice","Earth"], 2000, 1701,"res://Sprites/Enemies/Medium/dragon givre.png"]
	,#reddrag 93
	[248, 75, 62, 1, 1, 30, 96, 200, 200, ["None"],["None"], ["Dragon"], ["Psn","Stn","Ice"], ["Fire","Earth"], 4000, 2904,"res://Sprites/Enemies/Medium/dragon rouge.png"]
	,#zombidrag 94
	[268, 56, 67, 1, 1, 30, 24, 135, 200, ["Para"],["Status"], ["Undead","Dragon"], ["Fire"], ["Status","Psn","Stn","Death","Ice","Earth"], 999, 2331,"res://Sprites/Enemies/Medium/dragon zombie.png"]
	,#sphinx 95
	[164, 22, 41, 2, 1, 8, 72, 95, 150, ["None"],["None"], ["Beast"], ["None"], ["Earth"], 650, 1317,"res://Sprites/Enemies/Medium/sphinx.png"]
	,#manticore 96
	[228, 23, 57, 3, 1, 12, 120, 115, 132, ["None"],["None"], ["Beast"], ["None"], ["Earth"], 1160, 1160,"res://Sprites/Enemies/Medium/manticore.png"]
	,#redankylo 97
	[256, 60, 64, 3, 1, 38, 56, 130, 146, ["None"],["None"],["None"],["None"],["None"], 300, 1428,"res://Sprites/Enemies/Medium/red ankylosaur.png"]
	,#ankylo 98
	[352, 98, 88, 1, 1, 48, 48, 156, 144, ["None"],["None"],["None"],["None"],["None"], 1, 2610,"res://Sprites/Enemies/Medium/ankylosaur.png"]
	,#wyvern 99
	[212, 30, 53, 1, 1, 12, 96, 115, 150, ["Psn"], ["Psn"], ["Dragon"], ["None"], ["Earth"], 50, 1173,"res://Sprites/Enemies/Medium/vouivre.png"]
	,#wyrm 100
	[260, 40, 65, 1, 1, 22, 60, 131, 150, ["None"],["None"], ["Dragon"], ["None"], ["Earth"], 50, 1173,"res://Sprites/Enemies/Medium/guivre.png"]
	,#tyro 101
	[480, 64, 133, 1, 1, 10, 60, 200, 144, ["None"],["None"],["None"],["None"],["None"], 502, 3387,"res://Sprites/Enemies/Medium/allosaur.png"]
	,#trex 102
	[600, 115, 144, 1, 30, 10, 60, 200, 150, ["None"],["None"],["None"],["None"],["None"], 600, 7200,"res://Sprites/Enemies/Medium/t rex.png"]
	,#ocho 103
	[208, 20, 52, 3, 1, 24, 24, 116, 176, ["Psn"], ["Psn"], ["None"], ["Thdr"], ["Fire","Earth"], 102, 1224,"res://Sprites/Enemies/Medium/ochu.png"]
	,#naocho 104
	[344, 35, 86, 3, 1, 32, 24, 170, 200, ["Psn"], ["Psn"], ["None"], ["None"], ["None"], 500, 3189,"res://Sprites/Enemies/Medium/neochu.png"]
	,#hydra 105
	[212, 30, 53, 3, 1, 14, 36, 116, 138, ["None"],["None"], ["Dragon"], ["None"], ["None"], 150, 915,"res://Sprites/Enemies/Medium/hydre.png"]
	,#redhydra 106
	[182, 20, 46, 3, 1, 14, 36, 103, 152, ["None"],["None"], ["Dragon"], ["Ice"], ["Fire"], 400, 1215,"res://Sprites/Enemies/Medium/redhydre.png"]
	,#naga 107
	[356, 9, 71, 1, 1, 8, 72, 116, 200, ["Psn"], ["Psn"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 2355, 2355,"res://Sprites/Enemies/Medium/seanaga.png"]
	,#grnaga 108
	[420, 7, 88, 1, 1, 16, 48, 143, 154, ["Psn"], ["Psn"], ["None"], ["None"], ["None"], 4000, 3489,"res://Sprites/Enemies/Medium/greynaga.png"]
	,#chimera 109
	[300, 30, 60, 4, 1, 20, 72, 130, 200, ["None"],["None"], ["Beast"], ["Ice"], ["Fire","Earth"], 2500, 2064,"res://Sprites/Enemies/Medium/chimere.png"]
	,#jimera 110
	[350, 40, 70, 4, 1, 18, 60, 143, 200, ["None"],["None"], ["Beast"], ["Ice"], ["Fire","Earth"], 5000, 4584,"res://Sprites/Enemies/Medium/gorgimere.png"]
	,#gasdragon 111
	[352, 72, 68, 1, 1, 16, 96, 200, 200, ["None"],["None"], ["Dragon"], ["Ice"], ["Earth"], 5000, 4068,"res://Sprites/Enemies/Medium/gasdragon.png"]
	,#bluedragon 112
	[454, 92, 86, 1, 1, 20, 96, 200, 200, ["None"],["None"], ["Dragon"], ["Fire"], ["Thdr","Earth"], 2000, 3274,"res://Sprites/Enemies/Medium/bluedragon.png"]
	,#mudgol 113
	[176, 64, 44, 1, 1, 7, 28, 93, 200, ["Psn"], ["Psn"], ["Giant"], ["None"], ["Status","Psn","Stn","Death","Fire","Ice","Thdr"], 800, 1257,"res://Sprites/Enemies/Medium/golem argirl.png"]
	,#rockgol 114
	[200, 70, 50, 1, 1, 16, 24, 110, 200, ["None"],["None"], ["Giant"], ["None"], ["Status","Psn","Stn","Death","Fire","Ice","Thdr","Earth"], 1000, 2385,"res://Sprites/Enemies/Medium/golem roche.png"]
	,#irongol 115
	[304, 93, 76, 1, 1, 100, 24, 143, 200, ["None"],["None"], ["Giant"], ["None"], ["Status","Psn","Stn","Death","Fire","Ice","Earth"], 3000, 6717,"res://Sprites/Enemies/Medium/golem fer.png"]
	,#Madpony 116
	[64, 10, 16, 2, 1, 2, 22, 40, 106, ["None"],["None"],["None"],["None"],["None"], 15, 63,"res://Sprites/Enemies/Medium/unicorn.png"]
	,#Nitemare 117
	[200, 30, 50, 3, 1, 24, 132, 100, 200, ["None"],["None"], ["Mage"], ["Ice"], ["Status","Psn","Stn","Death","Fire","Earth"], 700, 1272,"res://Sprites/Enemies/Medium/cauchemar.png"]
	,#warmech 118
	[2000, 128, 200, 2, 1, 80, 96, 200, 200, ["None"],["None"], ["Regen"], ["None"], ["Status","Psn","Stn","Death","Fire","Ice","Thdr","Earth"], 32000, 32000,"res://Sprites/Enemies/Medium/warmech.png"]
	,#lich1 119 - BOSS START
	[400, 40, 49, 1, 1, 40, 24, 120, 255, ["Para"],["Status"], ["Mage","Undead"], ["None"], ["Status","Psn","Stn","Death","Ice"], 3000, 2200,"res://Sprites/Enemies/Boss/lich.png"]
	,#lich2 120
	[500, 50, 64, 1, 1, 50, 48, 140, 255, ["Para"],["Status"], ["Mage","Undead"], ["None"], ["Status","Psn","Stn","Death","Ice"], 1, 2000,"res://Sprites/Enemies/Boss/lich.png"]
	,#kary1 121
	[600, 40, 63, 6, 1, 50, 48, 183, 255, ["None"],["None"], ["Mage"], ["Status"], ["Psn","Stn","Fire","Ice","Thdr"], 3000, 2475,"res://Sprites/Enemies/Boss/marilith.png"]
	,#kary2 122
	[700, 60, 63, 6, 1, 60, 60, 183, 255, ["None"],["None"], ["Mage"], ["None"], ["Psn","Stn","Fire","Ice","Thdr"], 1, 2000,"res://Sprites/Enemies/Boss/marilith.png"]
	,#kraken1 123
	[800, 50, 90, 8, 1, 60, 84, 160, 255, ["None"],["None"], ["Aqua"], ["Thdr"], ["Fire","Earth"], 5000, 4245,"res://Sprites/Enemies/Boss/kraken.png"]
	,#kraken2 124
	[900, 70, 114, 8, 1, 70, 98, 200, 255, ["None"],["None"], ["Aqua"], ["None"], ["Fire","Earth"], 1, 2000,"res://Sprites/Enemies/Boss/kraken.png"]
	,#tiamat1 125
	[1000, 49, 80, 4, 1, 80, 72, 200, 255, ["None"],["None"], ["Dragon"], ["Psn","Stn"], ["Fire","Ice","Thdr","Earth"], 6000, 5496,"res://Sprites/Enemies/Boss/tiamat.png"]
	,#tiamat2 126
	[1100, 75, 85, 4, 1, 90, 90, 200, 255, ["None"],["None"], ["Dragon"], ["None"], ["Fire","Ice","Thdr","Earth"], 1, 2000,"res://Sprites/Enemies/Boss/tiamat.png"]
	,#chaos 127
	[2000, 49, 80, 4, 1, 80, 72, 200, 255, ["Para"],["Status"], ["None"], ["None"], ["Status","Psn","Stn","Time","Death","Fire","Ice","Thdr","Earth"], 0, 0,"res://Sprites/Enemies/Boss/chaos.png"]
]
