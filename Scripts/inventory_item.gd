extends RichTextLabel

@export var item = 0
@export var connectedNode: Control
@export var connectedImage: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(str(int(GlobalVariables.inventory[item])))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count = int(GlobalVariables.inventory[item])
	text = str(count)
	if count == 0:
		connectedNode.visible = false
		connectedImage.visible = false
		visible = false
