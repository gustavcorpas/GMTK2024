extends Area2D

@export var rotationSpeed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += rotationSpeed * delta
	pass


func _on_body_entered(body: Node2D) -> void:
	print("player touch")
	queue_free()
	pass # Replace with function body.
