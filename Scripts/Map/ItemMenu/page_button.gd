extends Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_focus():
		if Input.is_action_just_pressed("ui_right"):
			get_parent().currentPage += 1
			text = "P." + str(get_parent().currentPage)
			get_tree().call_group("instanced_items", "queue_free")
			get_parent().updateInfoItem()
		elif Input.is_action_just_pressed("ui_left"):
			get_parent().currentPage -= 1
			text = "P." + str(get_parent().currentPage)
			get_tree().call_group("instanced_items", "queue_free")
			get_parent().updateInfoItem()
