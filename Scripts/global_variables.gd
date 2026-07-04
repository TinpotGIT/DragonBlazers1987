extends Node

var global_allies = [1, 3, 5, 2]
var global_levels = [0, 0, 0, 0]
var global_names = ["AAAA", "BBBB", "CCCC", "DDDD"]
#STR, AGL, INT, VIT, LUCK, ACC, MDEF
var global_stats = [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0 ,0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]]
var global_charges = [
	[[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]],
	[[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]],
	[[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]],
	[[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
]
var global_spells = [
	[[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
	[[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
	[[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
	[[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
]

var global_equipment_inventory = [
	[[0, 0, 0, 0], [0, 0, 0, 0]],
	[[0, 0, 0, 0], [0, 0, 0, 0]],
	[[0, 0, 0, 0], [0, 0, 0, 0]],
	[[0, 0, 0, 0], [0, 0, 0, 0]]
]

var global_is_equipped = [
	[[false, false, false, false], [false, false, false, false]],
	[[false, false, false, false], [false, false, false, false]],
	[[false, false, false, false], [false, false, false, false]],
	[[false, false, false, false], [false, false, false, false]]
]

var global_hp = [[0, 0], [0, 0], [0, 0], [0, 0]]
var global_status = ["", "", "", ""]
var next_battle = [[0, 0]]
var team_formation = [2, 3, 0, 1]
var inventory = [0, 0, 0]
