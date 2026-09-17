extends Node2D

var shopItems = []

func _on_button_focus_entered(extra_arg_0: NodePath) -> void:
	$HandCursor.position = Vector2(get_node(extra_arg_0).position.x - 12, get_node(extra_arg_0).position.y + 10)
