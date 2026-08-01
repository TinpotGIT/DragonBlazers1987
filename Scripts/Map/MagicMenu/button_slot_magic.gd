extends Button

@export var id_i = 1
@export var id_j = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent()
	focus_entered.connect(main._on_button_focus_entered.bind(get_path(), id_i, id_j))
