extends Area2D

@export var scenePath :=  "res://scenes/gameplay/Level1.tscn"
@onready var win: AudioStreamPlayer2D = $win
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var should_continue = false

func _on_body_entered(body: Node2D) -> void:
	if not body.name == "Player":
		return
	should_continue = true
	animated_sprite_2d.play("open")
	win.play()


func _on_win_finished() -> void:
	if not should_continue: return
	get_tree().change_scene_to_file(scenePath)
