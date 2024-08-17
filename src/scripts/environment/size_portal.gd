extends Portal

func _on_augment(body) -> void:
	if effect_activator == true && body.has_method("size_up"):
		body.size_up()
	for connection in connections:	
		if connection.has_method("size_up"):
			connection.size_up()
		else:
			print_debug("MISSING SIZE UP METHOD!")
			


func _on_diminish(body) -> void:
		if effect_activator == true && body.has_method("size_down"):
			body.size_down()
		for connection in connections:	
			if connection.has_method("size_down"):
				connection.size_down()
			else:
				print_debug("MISSING SIZE DOWN METHOD!")
			
