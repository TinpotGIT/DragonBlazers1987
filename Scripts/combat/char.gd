extends AnimatedSprite2D

var idle_name = ""
var attack_name = ""
var run_name = ""
var ko_name = ""
var victory_name = ""

func animationCheck(number):
	match number:
		0:
			idle_name = "warrior_idle"
			attack_name = "warrior_attack"
			run_name = "warrior_run"
			ko_name = "warrior_ko"
			victory_name = "warrior_victory"
		1:
			idle_name = "thief_idle"
			attack_name = "thief_attack"
			run_name = "thief_run"
			ko_name = "thief_ko"
			victory_name = "thief_victory"
		2:
			idle_name = "bbelt_idle"
			attack_name = "bbelt_attack"
			run_name = "bbelt_run"
			ko_name = "bbelt_ko"
			victory_name = "bbelt_victory"
		3:
			idle_name = "rmage_idle"
			attack_name = "rmage_attack"
			run_name = "rmage_run"
			ko_name = "rmage_ko"
			victory_name = "rmage_victory"
		4:
			idle_name = "wmage_idle"
			attack_name = "wmage_attack"
			run_name = "wmage_run"
			ko_name = "wmage_ko"
			victory_name = "wmage_victory"
		5:
			idle_name = "bmage_idle"
			attack_name = "bmage_attack"
			run_name = "bmage_run"
			ko_name = "bmage_ko"
			victory_name = "bmage_victory"

func idle():
	play(idle_name)

func run():
	play(run_name)

func attack():
	play(attack_name)

func ko():
	play(ko_name)
	
func victory():
	play(victory_name)
