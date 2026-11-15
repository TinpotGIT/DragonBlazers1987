extends CharacterBody2D

const tile_size: Vector2 = Vector2(16, 16)
var sprite_node_pos_tween: Tween
var rng = RandomNumberGenerator.new()
var encounterID = 0

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
	_move(vector)
	$AnimatedSprite2D.play(animation)
	_random_encounter()

func _random_encounter():
	var number = rng.randi_range(1, 500)
	if number == 2:
		get_tree().change_scene_to_file("res://Scenes/MainScenes/combat.tscn")
		
func _move(dir: Vector2):
	if test_move(global_transform, dir * tile_size):
		return
	global_position += dir * tile_size
	$AnimatedSprite2D.global_position -= dir * tile_size
		
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($AnimatedSprite2D, "global_position", global_position, 0.3).set_trans(Tween.TRANS_LINEAR)

func _on_body_entered(body: Node2D, extra_arg_0: Array) -> void:
	GlobalVariables.next_battle = extra_arg_0
