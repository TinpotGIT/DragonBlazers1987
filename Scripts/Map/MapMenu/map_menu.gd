extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 7, get_node(extra_arg_0).position.y + 10)


func _on_status_button_pressed() -> void:
	get_parent().get_parent().actionList.append("Status")
	$CharButton0.grab_focus()

func _on_magic_button_pressed() -> void:
	get_parent().get_parent().actionList.append("Magic")
	$CharButton0.grab_focus()

func _on_formation_button_pressed() -> void:
	get_parent().get_parent().actionList.append("FormationReady")
	$CharButton0.grab_focus()

func _on_save_button_pressed() -> void:
	$SaveTimer.start()
	$SaveWindow.visible = true
	$HandCursor.visible = false
	get_viewport().gui_release_focus()
	$SFX.stream = load("res://Sounds/save_jingle.mp3")
	$SFX.play()
	$Background.save_game()
	

func _on_save_timer_timeout() -> void:
	$SaveWindow.visible = false
	$HandCursor.visible = true
	$Items_Button.grab_focus()
