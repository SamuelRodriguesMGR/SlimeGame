extends Node3D

 
@onready var camera_controller : Node3D = get_node("CameraController")

var SLIME_SCENE : PackedScene = load("res://Scenes/Characters/Player/player.tscn")

var zoomfactor        : int = 1 : set = _set_player
var players           : Array[Node]
var timer_delay_wheel : Timer = Timer.new()
var timer_fall_clime  : Timer = Timer.new()
var ending            : bool = false
var backlight_color   : Color = Color.CYAN

func _ready() -> void:
	add_child(timer_delay_wheel)
	add_child(timer_fall_clime)
	timer_delay_wheel.one_shot = true
	timer_fall_clime.one_shot = true
	GlobalVars.current_slime = get_node("Player")
	GlobalVars.current_slime.sprite.modulate = backlight_color
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and timer_delay_wheel.is_stopped():
		timer_delay_wheel.start(0.1)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoomfactor += 1
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoomfactor -= 1
	
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
		

func _set_player(new_zoomfactor) -> void:
	players = get_tree().get_nodes_in_group("PLAYER_GROUP")
	
	if players.is_empty():
		return
		
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
			GlobalVars.current_slime.sprite.modulate = backlight_color
			
	if ending and timer_fall_clime.is_stopped():
		timer_fall_clime.start(0.1)
		var x = randi_range(16, 38)
		var y = randi_range(17, 20)
		var z = randi_range(-31, -9)
		
		var rand_vec3 = Vector3(x, y, z)
		_add_slime(rand_vec3)
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("PLAYER_GROUP") and not ending:
		$AudioStreamPlayer.play()
		ending = true
		timer_fall_clime.start()
		
func _add_slime(pos):
	var new_slime = SLIME_SCENE.instantiate()
	get_tree().current_scene.add_child(new_slime)
	new_slime.global_position = pos
