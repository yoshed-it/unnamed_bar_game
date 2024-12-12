extends Node


const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

# Should serialize to binary
var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		intox = 1,
		max_intox = 1,
		stress = 1,
		max_stress = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = []
}


func save_game() -> void:
	#update_player_data()
	#update_scene_path()
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	
	file.store_line(save_json)
	game_saved.emit()
	
	print("Save Game")
	pass
	
func load_game() -> void:
	print("Load Game")
	pass
	
	
func update_player_data() -> void:
	pass
	#var player : Player = PlayerManager.player
	#
	#current_Save.player.hp = player.hp
	#current_Save.player.max_hp = player.max_hp
	#current_Save.player.intox = player.intox
	#current_Save.player.max_intox = player.max_intox
	#current_Save.player.stress = player.stress
	#current_Save.player.max_stress = player.max_stress
	#current_Save.player.pos_x = player.global_position.x
	#current_Save.player.pos_y = player.global_position.y
	

#func update_scene_path() -> void:
	#var path : String = ""
	#
	#for child in get_tree().root.get_children():
		#if child is Level:
			#path = child.scene_file_path
			#
	#current_save.scene_path = path
		#
