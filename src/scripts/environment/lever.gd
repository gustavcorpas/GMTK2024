extends Area2D

var player_in_range = false
var activated = false

signal lever_triggered(activated)

func _on_body_entered(body: Node2D) -> void:
	
	player_in_range = true
	_listen_for_interaction()
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	player_in_range = false
	pass # Replace with function body.


func _listen_for_interaction():
	
	while(player_in_range):
		
		await get_tree().create_timer(0.001).timeout
		
		if Input.is_action_just_pressed("interact"):
			print("heave ho")
			activated = !activated
			lever_triggered.emit(activated)
			
			scale.x = -scale.x
	
	
	pass
