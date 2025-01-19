extends Control


func _ready() -> void:
	$AudioBackground.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
