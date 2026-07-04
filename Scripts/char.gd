extends AnimatedSprite2D

var idle_name = ""
var attack_name = ""
var run_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func animationCheck(number):
	match GlobalVariables.global_allies[number]:
		0.0:
			idle_name = "warrior_idle"
			attack_name = "warrior_attack"
			run_name = "warrior_run"
		1.0:
			idle_name = "thief_idle"
			attack_name = "thief_attack"
			run_name = "thief_run"
		2.0:
			idle_name = "bbelt_idle"
			attack_name = "bbelt_attack"
			run_name = "bbelt_run"
		3.0:
			idle_name = "rmage_idle"
			attack_name = "rmage_attack"
			run_name = "rmage_run"
		4.0:
			idle_name = "wmage_idle"
			attack_name = "wmage_attack"
			run_name = "wmage_run"
		5.0:
			idle_name = "bmage_idle"
			attack_name = "bmage_attack"
			run_name = "bmage_run"

func idle():
	play(idle_name)

func run(run_animation):
	play(run_name)

func attack():
	play(attack_name)


func _on_enemy_focus_entered(extra_arg_0: NodePath) -> void:
	pass # Replace with function body.
