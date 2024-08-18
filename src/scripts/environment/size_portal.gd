extends Portal

@onready var count: RichTextLabel = $count

func update_text():
	if max_emit_count > 0:
		count.text = "%s/%s" % [usage_count, max_emit_count]
		


func _on_augment(body) -> void:
	if effect_activator == true && body.has_method("size_up"):
		body.size_up()
	for connection in connections:	
		if connection.has_method("size_up"):
			connection.size_up()
		else:
			print_debug("MISSING SIZE UP METHOD!")
	
	update_text()


func _on_diminish(body) -> void:
		if effect_activator == true && body.has_method("size_down"):
			body.size_down()
		for connection in connections:	
			if connection.has_method("size_down"):
				connection.size_down()
			else:
				print_debug("MISSING SIZE DOWN METHOD!")
		
		update_text()


func _on_ready() -> void:
	update_text()
