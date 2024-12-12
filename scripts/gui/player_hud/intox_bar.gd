class_name StresBar extends ProgressBar

@export var player: Player


func _ready() -> void:
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("green")
	#player.intox_changed.connect(update_intox)
	#update_intox()
	#
#func update_intox():
	#value = player.current_intox * 100 / player.max_intox
	#

	
