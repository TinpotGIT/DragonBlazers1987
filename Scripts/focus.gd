extends Button

func _ready() -> void:
	var main = get_parent().get_parent()
	focus_entered.connect(main._on_button_focus_entered.bind(get_path()))
	pressed.connect(main._on_attack_pressed)
	grab_focus.call_deferred()
	print("connected attack")
