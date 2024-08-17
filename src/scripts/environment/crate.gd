extends RigidBody2D

func _on_crater_freezer_body_entered(body: Node2D) -> void:
	
	print("player stood on crate")
	set_deferred("freeze", true)
	
	pass # Replace with function body.


func _on_crater_freezer_body_exited(body: Node2D) -> void:
	
	print("player got off crate")
	set_deferred("freeze", false)
	
	pass # Replace with function body.
