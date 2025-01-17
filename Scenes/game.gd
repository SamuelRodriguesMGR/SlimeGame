extends Node3D

 
@onready var camera_controller : Node3D = get_node("CameraController")

var zoomfactor        : int = 1 : set = _set_player
var players           : Array[Node]
var timee_delay_wheel : Timer = Timer.new()
var backlight_color   : Color = Color.CYAN

func _ready() -> void:
	add_child(timee_delay_wheel)
	timee_delay_wheel.one_shot = true
	GlobalVars.current_slime = get_node("Player")
	GlobalVars.current_slime.sprite.modulate = backlight_color
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and timee_delay_wheel.is_stopped():
		timee_delay_wheel.start(0.1)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoomfactor += 1
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoomfactor -= 1

func _set_player(new_zoomfactor) -> void:
	players = get_tree().get_nodes_in_group("PLAYER_GROUP")
	zoomfactor = new_zoomfactor
	
	if zoomfactor < 0:
		zoomfactor = players.size() - 1
	elif zoomfactor > players.size() - 1:
		zoomfactor = 0
	
	for player in players:
		player.sprite.modulate = Color.WHITE
		
	GlobalVars.current_slime = players[zoomfactor]
	GlobalVars.current_slime.sprite.modulate = backlight_color
	
		
func _process(_delta: float) -> void:
	
	if GlobalVars.current_slime == null:
		players = get_tree().get_nodes_in_group("PLAYER_GROUP")
		
		if players.size() != 0:
			var new_player = randi_range(0, players.size() - 1)
			GlobalVars.current_slime = players[new_player]
			
