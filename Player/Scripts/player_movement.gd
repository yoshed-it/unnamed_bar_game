class_name PlayerMovement extends CharacterBody2D

var move_speed : float = 100.0
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var sprite2D : Sprite2D = get_node("Sprite2D")
@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
#Apparently you can short hand it ---------> $AnimationPlayer


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("player_right") - Input.get_action_raw_strength("player_left")
	direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	direction = direction.normalized()
	
	velocity = direction * move_speed
#	Do something here with velocity to change movement speed when drinking or abusing other substances like "mysterious white powder"
	if set_state() == true || set_direction() == true:
		update_animation()


func _physics_process(delta: float) -> void:
	move_and_slide()


func set_direction() -> bool:
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
	
	
func set_state() -> bool:
	var new_state : String = 'idle' if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
	
func update_animation() -> void:
	var animation_name = state + "_" + animation_direction()
	print("Now Playing {animation_name} Animation")
	animation_player.play(state + "_" + animation_direction())


func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return 'down'
	elif cardinal_direction == Vector2.UP:
		return 'up'
	elif cardinal_direction == Vector2.LEFT:
		return 'left'
	else:
		return 'right'	
	
	
