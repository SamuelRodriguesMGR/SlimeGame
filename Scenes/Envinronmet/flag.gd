extends Area3D




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("PLAYER_GROUP"):
		get_tree().call_deferred(
			"change_scene_to_file", "res://Scenes/Levels/level_%s.tscn" % (GlobalVars.current_level + 1)
			)
		GlobalVars.current_level += 1
