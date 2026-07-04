extends Button

var allyNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if allyNumber == 0:
		text = "FIGHTER"
	elif allyNumber == 1:
		text = "THIEF"
	elif allyNumber == 2:
		text = "BLACK BELT"
	elif allyNumber == 3:
		text = "RED MAGE"
	elif allyNumber == 4:
		text = "WHITE MAGE"
	elif allyNumber == 5:
		text = "BLACK MAGE"
