class_name Character extends CharacterBody3D 


@onready var state_machine : Node = get_node("FiniteStateMachine")
@onready var sprite        : Sprite3D = get_node("Sprite3D")

const SPEED          : float = 5.0
const MAX_SPEED      : float = 100.0
const JUMP_VELOCITY  : float = 5
const FRICTION       : float = 0.95
const GRAVITY_FACTOR : float = 1.2

var move_direction3d : Vector3 = Vector3.ZERO
var move_direction2d : Vector2

func _process(_delta: float) -> void:
	var direction : float = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif direction < 0 and not sprite.flip_h:
		sprite.flip_h = true
		
	if global_position.y < -10 or velocity.length() >= MAX_SPEED:
		kill()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	velocity.z = move_toward(velocity.z, 0, FRICTION)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_FACTOR

func move():
	if move_direction3d:
		velocity.x = move_direction3d.x * SPEED 
		velocity.z = move_direction3d.z * SPEED 
	
	velocity = velocity.limit_length(MAX_SPEED)

func kill():
	state_machine.set_state(state_machine.states.dead)
	
func death():
	GlobalVars.counter_dead += 1
	queue_free()
