extends Button

var id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent()
	focus_entered.connect(main._on_button_focus_entered.bind(get_path(), id))
	grab_focus.call_deferred()
