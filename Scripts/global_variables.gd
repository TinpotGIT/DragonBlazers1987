extends Node

var global_allies = [1, 3, 5, 2]
var global_levels = [1, 1, 1, 1]
var global_exp = [0, 0, 0, 0]
var global_names = ["AAAA", "BBBB", "CCCC", "DDDD"]
#STR, AGL, INT, VIT, LUCK, ACC, MDEF
var global_stats = [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0 ,0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]]
var gold = 400

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

var global_resistances = [
	[], [], [], []
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

var expTable = [
	0, 0, 40, 156, 351, 624, 975, 1404, 1911, 2496,
	3159, 3900, 4719, 5616, 6591, 7644, 8775, 9984,
	11272, 12636, 14079, 15600, 17199, 18877, 20631,
	22464, 24376, 26364, 28432, 30576, 32800
]

var global_hp = [[0, 0], [0, 0], [0, 0], [0, 0]]
var global_status = ["", "", "", ""]
var next_battle = [[0, 0]]
var team_formation = [2, 3, 0, 1]
var inventory = [0, 0, 0]
