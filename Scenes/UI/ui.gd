extends CanvasLayer


@onready var menu    : Control = get_node("Menu")
@onready var options : Control   = get_node("Options")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.hide()
	options.hide()
	
func _process(_delta: float) -> void:
	%CounterSlime.text = str(GlobalVars.counter_slimes)
	%CounterDead.text = str(GlobalVars.counter_dead)
	
func change_menu():
	GlobalVars.menu_is_active = not GlobalVars.menu_is_active
	menu.visible = not menu.visible
	
	if not GlobalVars.menu_is_active:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		change_menu()

func _on_play_pressed() -> void:
	change_menu()

func _on_options_pressed() -> void:
	options.show()

func _on_exit_pressed() -> void:
	GlobalVars.menu_is_active = false
	get_tree().change_scene_to_file("res://Scenes/UI/main.tscn")
