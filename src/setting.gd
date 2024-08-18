extends Control

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_music_value_changed(value: float):
	# AudioServer.set_bus_volume_db(0, value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_sound_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound SFX"), value)


func _on_return_pressed() -> void:
	print("return to main menu")
	get_tree().change_scene_to_file("res://scenes/MenuScenes/Main_menu.tscn")
 

 
 
