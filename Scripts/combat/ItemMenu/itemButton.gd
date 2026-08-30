extends Button

@export var isArmor = 0
@export var id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent().get_parent().get_parent()
	focus_entered.connect(main._on_button_focus_entered.bind(get_path()))
	pressed.connect(main._on_item_button_pressed.bind(isArmor, id))
