extends Character


var SLIME_SCENE : PackedScene = load("res://Scenes/Characters/Player/player.tscn")

func _add_slime():
	var new_slime = SLIME_SCENE.instantiate()
	get_tree().current_scene.add_child(new_slime)
	new_slime.global_position = global_position + Vector3.UP
	
func get_input():
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_VELOCITY
	
	if Input.is_action_just_pressed("left_mouse"):
		if GlobalVars.current_slime == self:
			_add_slime()
		
	move_direction2d = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func move():
	super()
	player_move()
	
func player_move():
	if GlobalVars.current_slime != null:
		move_direction3d = (get_tree().current_scene.camera_controller.transform.basis *
		Vector3(move_direction2d.x, 0, move_direction2d.y)).normalized()
