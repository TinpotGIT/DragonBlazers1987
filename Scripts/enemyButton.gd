extends TextureButton

@export var id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent()
	focus_entered.connect(main._on_enemy_focus_entered.bind(get_path()))
	pressed.connect(main._on_enemy_pressed.bind(id))

func _process(delta: float) -> void:
	if visible:
		get_parent().existingEnemies[id] = 1
	if get_parent().enemies[id] == [] or get_parent().enemies[id][1][0] <= 0:
		visible = false
