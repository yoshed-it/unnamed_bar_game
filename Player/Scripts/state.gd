class_name State extends Node

## Stores ref to player that this state belongs to
static var player: Player


## Called when node enteres the scene tree for the FIRST time
func _ready():
	pass
	
	
## What Happens when the player enteres this state?
func Enter() -> void:
	pass

## What Happens when the player exits this state?
func Exit() -> void:
	pass
	
## What happens during the _process update in this state?
func Process(_delta : float) -> State:
	return null 
	
## What happens during the _physics_process update in this state?
func Physics(_delta : float) -> State:
	return null
	
## What happens with input events in this state?
func HandleInput (_event : InputEvent) -> State:
	return null	

	
