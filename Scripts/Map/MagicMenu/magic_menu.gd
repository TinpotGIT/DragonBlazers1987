extends Control

var id = 0

func getId(newId):
	id = newId

func updateInfoMagic():
	var trueId = GlobalVariables.team_formation[id]
	for i in range(len(GlobalVariables.global_spells[trueId])):
		for j in range(len(GlobalVariables.global_spells[trueId][0])):
			get_node("SpellSlot"+str(i)+str(j)).text = str($BackgroundObjetsMagies.Spells[GlobalVariables.global_spells[trueId][i][j]][0])
	$ButtonSlot0.grab_focus.call_deferred()
	for k in range(8):
		get_node("Charges"+str(k)).text = (str(int(GlobalVariables.global_charges[trueId][k][0])) + "/" + str(int(GlobalVariables.global_charges[trueId][k][1])))
	
func _on_button_focus_entered(extra_arg_0: NodePath, id_i: int, id_j: int) -> void:
	var trueId = GlobalVariables.team_formation[id]
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 9, get_node(extra_arg_0).position.y + 10)
	$Description.text = str($BackgroundObjetsMagies.SpellDescriptions[GlobalVariables.global_spells[trueId][id_i][id_j]])
