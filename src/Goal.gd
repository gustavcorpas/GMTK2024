extends Area2D




func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay/Level2.tscn")
	pass # Replace with function body.
