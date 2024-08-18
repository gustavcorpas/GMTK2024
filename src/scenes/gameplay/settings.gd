extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_master_value_changed(value: float):
	# AudioServer.set_bus_volume_db(0, value)
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_master_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_music_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_volume_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound SFX"), value)



func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay/Main_menu.tscn") 
 
