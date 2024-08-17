extends Area2D

@export var scenePath :=  "res://scenes/gameplay/Level1.tscn"


func _on_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file(scenePath)
	pass # Replace with function body.
