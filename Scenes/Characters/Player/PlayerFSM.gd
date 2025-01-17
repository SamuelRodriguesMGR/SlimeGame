extends FiniteStateMachine


func _init() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("jump")
	_add_state("dead")

func _ready() -> void:
	set_state(states.idle)
	
	
func _state_logic(_delta: float) -> void:
	if state in [states.idle, states.move, states.jump]:
		parent.get_input()
		parent.move()
	
	
func _get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > parent.SPEED:
				return states.move
			if not parent.is_on_floor():
				return states.jump
				
		states.move:
			if parent.velocity.length() < parent.SPEED:
				return states.idle
			if not parent.is_on_floor():
				return states.jump
				
		states.jump:
			if parent.is_on_floor():
				return states.idle
			
	return -1
	
	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")
		states.jump:
			animation_player.play("jump")
		states.dead:
			animation_player.play("dead")
