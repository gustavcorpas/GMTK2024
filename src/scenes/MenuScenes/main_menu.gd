extends Control

 
func _on_start_game_pressed() -> void:
	print("Start Game pressed")
	get_tree().change_scene_to_file("res://scenes/GameLevels/Lvl1.tscn")

func _on_settings_pressed() -> void:
	print("Setting pressed")
	get_tree().change_scene_to_file("res://scenes/MenuScenes/Setting.tscn")


func _on_exit_game_pressed() -> void:
	print("Exit Game pressed")
	get_tree().quit()
 
