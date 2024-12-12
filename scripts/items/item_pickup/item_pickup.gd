@tool

class_name ItewmPickup extends Node

@export var item_data : ItemData : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Area2D/CollisionShape2D/Sprite2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area2d.body_entered.connect( _on_body_entered)

func _on_body_enter(body) -> void:
	if body is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data):
				item_picked_up()
	pass
	

func item_picked_up() -> void:
	pass
	

func _update_texture() -> void:
	pass


func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	
	pass
