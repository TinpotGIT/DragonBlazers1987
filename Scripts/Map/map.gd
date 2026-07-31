extends Node2D

var inMenu = false
var chosenButton = "None"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("The exp is : " + str(GlobalVariables.global_exp))
	print("")
	print("The levels are : " + str(GlobalVariables.global_levels))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"): 
		print("chosen button is : " + chosenButton)
		print(inMenu)
		if inMenu == false:
			hideMenus()
			chosenButton = "None"
			$CharacterBody2D/MapMenu.visible = true
			$CharacterBody2D/MapMenu/Items_Button.grab_focus.call_deferred()
			showAllCharInfo()
			inMenu = true
			print("DDDDD")
		elif (inMenu == true) and (chosenButton == "None"):
			$CharacterBody2D/MapMenu.visible = false
			inMenu = false
			print("AEAEAEA")
		elif chosenButton != "None":
			print("BBBBBB")
			$CharacterBody2D/MapMenu/Items_Button.grab_focus.call_deferred()
			chosenButton = "None"

func hideMenus():
	$CharacterBody2D/StatMenu.visible = false
	$CharacterBody2D/ItemMagicMenu.visible = false

func showAllCharInfo():
	$CharacterBody2D/MapMenu/CharSlot0.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot1.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot2.showCharInfo()
	$CharacterBody2D/MapMenu/CharSlot3.showCharInfo()

func checkChosen(id):
	if chosenButton == "Status":
		$CharacterBody2D/StatMenu.visible = true
		$CharacterBody2D/StatMenu.getId(id)
		$CharacterBody2D/StatMenu.updateInformation()
		$CharacterBody2D/MapMenu.visible = false
		inMenu = false
		
func itemPressed():
	chosenButton = "Items"
	$CharacterBody2D/ItemMagicMenu.visible = true
	$CharacterBody2D/ItemMagicMenu.updateInfoItems()
	$CharacterBody2D/MapMenu.visible = false
	inMenu = false
