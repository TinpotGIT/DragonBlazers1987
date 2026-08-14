extends AnimatedSprite2D

var idle_name = ""
var attack_name = ""
var run_name = ""
var ko_name = ""

func animationCheck(number):
	match GlobalVariables.global_allies[number]:
		0:
			idle_name = "warrior_idle"
			attack_name = "warrior_attack"
			run_name = "warrior_run"
			ko_name = "warrior_ko"
		1:
			idle_name = "thief_idle"
			attack_name = "thief_attack"
			run_name = "thief_run"
			ko_name = "thief_ko"
		2:
			idle_name = "bbelt_idle"
			attack_name = "bbelt_attack"
			run_name = "bbelt_run"
			ko_name = "bbelt_ko"
		3:
			idle_name = "rmage_idle"
			attack_name = "rmage_attack"
			run_name = "rmage_run"
			ko_name = "rmage_ko"
		4:
			idle_name = "wmage_idle"
			attack_name = "wmage_attack"
			run_name = "wmage_run"
			ko_name = "wmage_ko"
		5:
			idle_name = "bmage_idle"
			attack_name = "bmage_attack"
			run_name = "bmage_run"
			ko_name = "bmage_ko"
	print(idle_name)
func idle():
	play(idle_name)

func run():
	play(run_name)

func attack():
	play(attack_name)

func ko():
	play(ko_name)

func _on_enemy_focus_entered(extra_arg_0: NodePath) -> void:
	pass # Replace with function body.
