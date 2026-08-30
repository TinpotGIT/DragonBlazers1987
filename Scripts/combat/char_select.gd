extends Button

@export var id = 0

func _ready() -> void:
	var main = get_parent()
	focus_entered.connect(main._on_char_focus_entered.bind(get_path(), id))
	pressed.connect(main._on_char_select_pressed.bind(id))
