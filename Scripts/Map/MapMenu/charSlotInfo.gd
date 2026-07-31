extends Control

var classNames = ["COMBATTANT","VOLEUR","MOINE","MAGE ROUGE","MAGE BLANC","MAGE NOIR"]
var animNames = ["warrior_idle","thief_idle","bbelt_idle","rmage_idle","wmage_idle","bmage_idle"]
@export var id = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	showCharInfo()

func showCharInfo():
	var correctID = GlobalVariables.team_formation[id]
	$Status.text = GlobalVariables.global_status[correctID]
	$ClassName.text = classNames[GlobalVariables.global_allies[correctID]]
	$CharName.text = GlobalVariables.global_names[correctID]
	$HP.text = "HP " + str(int(GlobalVariables.global_hp[correctID][0])) + "/" + str(int(GlobalVariables.global_hp[correctID][1]))
	$Level.text = "NIVEAU " + str(GlobalVariables.global_levels[correctID])
	$Char0.play(animNames[GlobalVariables.global_allies[correctID]])
	var charges = GlobalVariables.global_charges[correctID]
	print(charges)
	$Charges.text = str(int(charges[0][0])) + "/" + str(int(charges[1][0])) + "/" + str(int(charges[2][0])) + "/" + str(int(charges[3][0])) + "/" + str(int(charges[4][0])) + "/" + str(int(charges[5][0])) + "/" + str(int(charges[6][0])) + "/" + str(int(charges[7][0]))
