extends RichTextLabel

var id = 0
@export var level = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	id = get_node("../../../..").charSelected
	text = str(int(GlobalVariables.global_charges[id][level][0]))
