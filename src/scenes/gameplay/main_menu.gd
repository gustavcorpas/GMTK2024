extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	print("Start Game pressed")
	get_tree().change_scene_to_file("res://scenes/gameplay/Level1.tscn")

func _on_settings_pressed() -> void:
	print("Setting pressed")
	get_tree()


func _on_exit_game_pressed() -> void:
	print("Exit Game pressed")
	get_tree().quit()
