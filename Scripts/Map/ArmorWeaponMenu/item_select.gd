extends Button

@export var equipID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent().get_parent().get_parent()
	var charID = get_parent().get_parent().id
	focus_entered.connect(main._on_button_focus_entered.bind(get_path()))
	pressed.connect(main._on_item_select_pressed.bind(equipID, charID))
