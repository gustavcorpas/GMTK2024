extends Area2D

var player_in_range = false
var activated = false

signal lever_triggered(activated)

@export var portal_connections: Array[Portal] = []



func _on_body_entered(body: Node2D) -> void:
	player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	player_in_range = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		activated = !activated
		lever_triggered.emit(activated)


func _on_lever_triggered(activated: Variant) -> void:
	for portal in portal_connections:
		portal.flip()
