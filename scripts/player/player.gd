class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var sprite2D : Sprite2D = $Sprite2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var state_machine : PlayerStateMachine = $StateMachine


func _ready() -> void:
	state_machine.Init(self)
	
	
func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("player_right") - Input.get_action_raw_strength("player_left")
	direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	direction = direction.normalized()


func _physics_process(delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	return true

	
func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimationDirection())


func AnimationDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return 'down'
	elif cardinal_direction == Vector2.UP:
		return 'up'
	elif cardinal_direction == Vector2.LEFT:
		return 'left'
	else:
		return 'right'	
	
	
