extends TileMapLayer

# NOM, EFFICACITE, PRECISION, ELEMENT, CIBLE, EFFET, NIVEAU, USAGER

var Spells = [
	["", 0, 0, "None", "R", -1, -1, []],
	["SOIN", 16, -1, "None", "SA", 0, 1, ["WM", "RM", "KN"]],
	["SOIN2", 16, -1, "None", "AA", 0, 1, ["WM", "RM", "KN"]],
	["OUILLE", 16, -1, "None", "SE", 1, 1, ["WM", "RM", "KN"]],
	["COUILLE", 16, -1, "None", "AE", 1, 1, ["WM", "RM", "KN"]]
]

# Effets : 
#	Soin -> 0 | Dégats -> 1 | Stat UP/DOWN -> 2 | Status -> 3 | Guéris Status -> 4
#	Resist Element -> 5 | HitMul -> 6
# Quand tu fait Stat up ou Stat down au lieu de mettre juste la valeur d'efficacité
# Tu met, par exemple : [16, ID]
# ID -> HP_MAX : 0 | STR : 1 | AGL : 2 | INT : 3 | VIT : 4 
# LUCK : 5 | ACC : 6 | DEF : 7 | MDEF: 8 | MORAL: 9
