extends Button

@export var spellInfo = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent().get_parent().get_parent()
	focus_entered.connect(main._on_button_focus_entered.bind(get_path()))
	pressed.connect(main._on_spell_pressed.bind(spellInfo))
