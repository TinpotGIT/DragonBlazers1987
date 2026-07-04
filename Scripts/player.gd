extends CharacterBody2D

const tile_size: Vector2 = Vector2(16, 16)
var sprite_node_pos_tween: Tween
var rng = RandomNumberGenerator.new()
var encounterID = 0

func _physics_process(delta: float) -> void:
	if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
		if Input.is_action_pressed("ui_up") and !$up.is_colliding():
			_move(Vector2.UP)
			$AnimatedSprite2D.play("walk_up")
			_random_encounter()
		elif Input.is_action_pressed("ui_down") and !$down.is_colliding():
			_move(Vector2.DOWN)
			$AnimatedSprite2D.play("walk_down")
			_random_encounter()
		elif Input.is_action_pressed("ui_left") and !$left.is_colliding():
			_move(Vector2.LEFT)
			$AnimatedSprite2D.play("walk_left")
			_random_encounter()
		elif Input.is_action_pressed("ui_right") and !$right.is_colliding():
			_move(Vector2.RIGHT)
			$AnimatedSprite2D.play("walk_right")
			_random_encounter()
		else:
			$AnimatedSprite2D.stop()

func _random_encounter():
	var number = rng.randi_range(1, 2)
	if number == 2:
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
