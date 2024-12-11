extends CanvasLayer


@onready var button_save: Button = $VBoxContainer/button_save
@onready var button_load: Button = $VBoxContainer/button_load




var is_paused : bool = false


func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		print("esc pushed")
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		# Keeps this script from interacting with other scripts.
		get_viewport().set_input_as_handled()

		
func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()
	
	
func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	
	
func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass
	
	
func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	hide_pause_menu()
	pass
