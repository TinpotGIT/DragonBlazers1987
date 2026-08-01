extends Control

var id = 0

var classNames = ["COMBATTANT","VOLEUR","MOINE","MAGE ROUGE","MAGE BLANC","MAGE NOIR"]
var animNames = ["warrior_idle","thief_idle","bbelt_idle","rmage_idle","wmage_idle","bmage_idle"]

func getId(newId):
	id = newId

func updateInformation():
	var trueID = GlobalVariables.team_formation[id]
	$CharName.text = GlobalVariables.global_names[trueID]
	$Level.text = "NIVEAU " + str(GlobalVariables.global_levels[trueID])
	$ClassName.text = classNames[GlobalVariables.global_allies[trueID]]
	$CurrentExp.text = str(GlobalVariables.total_exp[trueID])
	$NeededExp.text = getNeededExp(GlobalVariables.global_levels[trueID] + 1) 
	$Str.text = str(int(GlobalVariables.global_stats[trueID][0]))
	$Agl.text = str(int(GlobalVariables.global_stats[trueID][1]))
	$Int.text = str(int(GlobalVariables.global_stats[trueID][2]))
	$Vit.text = str(int(GlobalVariables.global_stats[trueID][3]))
	$Luck.text = str(int(GlobalVariables.global_stats[trueID][4]))
	$CharImage.play(animNames[GlobalVariables.global_allies[trueID]])

	
func getNeededExp(level):
	var total = 0
	for i in range(level + 1):
		if i < 30:
			total += GlobalVariables.expTable[i]
		else:
			total += GlobalVariables.total_exp[30]
	return str(total)
