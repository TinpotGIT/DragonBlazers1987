extends CharacterBody2D

const tile_size: Vector2 = Vector2(16, 16)
var sprite_node_pos_tween: Tween
var rng = RandomNumberGenerator.new()
var encounterID = 0

@export var tile_map_layer: TileMapLayer

func _physics_process(delta: float) -> void:
	if (get_parent().actionList == []):
		if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
			if Input.is_action_pressed("ui_up"):
				_move_choice(Vector2.UP, "walk_up")
			elif Input.is_action_pressed("ui_down"):
				_move_choice(Vector2.DOWN, "walk_down")
			elif Input.is_action_pressed("ui_left"):
				_move_choice(Vector2.LEFT, "walk_left")
			elif Input.is_action_pressed("ui_right"):
				_move_choice(Vector2.RIGHT, "walk_right")
			else:
				$AnimatedSprite2D.stop()

func _move_choice(vector, animation):
	if is_tile_solid(vector):
		return
	var original_mask = collision_mask 
	_move(vector)
	movement_animation_check(vector, animation)
	if has_data(vector):
		var data = get_tile_data(vector)
		enter_area(data.get_custom_data("area_data"))
	
	_random_encounter()
	collision_mask = original_mask

func is_tile_solid(vector):
	return test_move(global_transform, vector * tile_size)

func get_tile_data(vector):
	var hit_pos = global_position
	var local_pos =  tile_map_layer.to_local(hit_pos)
	var map_coords = tile_map_layer.local_to_map(local_pos)
	var tile_data = tile_map_layer.get_cell_tile_data(map_coords)
	
	print(tile_data.get_custom_data("area_data"))
	return tile_data

func has_data(vector):
	collision_mask = 1 << (3 - 1)
	return test_move(global_transform, vector * tile_size)

func enter_area(area_id):
	match area_id:
		1:
			get_tree().change_scene_to_file("res://coneria.tscn")

func movement_animation_check(vector, animation):
	collision_mask = 1 << (2 - 1)
	if test_move(global_transform, vector * tile_size):
		$AnimatedSprite2D.play(animation+"_forest")
	else:
		$AnimatedSprite2D.play(animation)

func _random_encounter():
	var number = rng.randi_range(1, 500)
	if number == 999:
		get_tree().change_scene_to_file("res://Scenes/MainScenes/combat.tscn")
		
func _move(dir: Vector2):
	global_position += dir * tile_size
	$AnimatedSprite2D.global_position -= dir * tile_size
		
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($AnimatedSprite2D, "global_position", global_position, 0.3).set_trans(Tween.TRANS_LINEAR)

func _on_body_entered(body: Node2D, extra_arg_0: Array) -> void:
	GlobalVariables.next_battle = extra_arg_0
