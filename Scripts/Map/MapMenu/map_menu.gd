extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 7, get_node(extra_arg_0).position.y + 10)


func _on_status_button_pressed() -> void:
	get_parent().get_parent().chosenButton = "Status"
	$CharButton0.grab_focus()
