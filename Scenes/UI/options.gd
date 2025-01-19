extends Control


func _ready() -> void:
	%CheckBox.button_pressed = GlobalVars.duplicating_each_slug
	%HSlider.value           = GlobalVars.music_value
	
func _on_button_pressed() -> void:
	GlobalVars.music_value = %HSlider.value 
	GlobalVars.duplicating_each_slug = %CheckBox.button_pressed
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), GlobalVars.music_value)
	get_tree().change_scene_to_file("res://Scenes/UI/main.tscn")
