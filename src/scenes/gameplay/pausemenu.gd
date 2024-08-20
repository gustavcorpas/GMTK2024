extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().pause = false
	$AnimationPlayer.play_backwards("Blur_screen")
	
func pause():
	get_tree().pause = true
	$AnimationPlayer.play("Blur_screen")

func PressEcs():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()


func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://assets/audio/menutheme.tscn")

func _process(delta):
	PressEcs()
