extends Control


func _ready() -> void:
	%CheckBox.button_pressed = GlobalVars.duplicating_each_slug
	
func _on_button_pressed() -> void:
	hide()
	GlobalVars.duplicating_each_slug = %CheckBox.button_pressed
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), GlobalVars.music_value)
