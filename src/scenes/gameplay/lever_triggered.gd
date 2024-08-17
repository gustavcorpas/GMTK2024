extends Sprite2D

func _on_lever_lever_triggered(activated: Variant) -> void:
	print(activated)
	visible = !activated
