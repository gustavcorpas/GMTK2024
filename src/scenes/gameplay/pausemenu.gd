extends Control

var can_process_input = true  # Variable to control input processing

func _ready():
	$Animationpause.play("RESET")

func resume():
	get_tree().paused = false
	$Animationpause.play_backwards("Blur_screen")
	can_process_input = false  # Disable input processing temporarily
	await get_tree().create_timer(0.20).timeout  # Add a small delay before re-enabling input
	can_process_input = true  # Re-enable input processing

func pause():
	get_tree().paused = true
	$Animationpause.play("Blur_screen")

func PressEcs():
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()
	
func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	PressEcs()

func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://scenes/gameplay/Pausemenu.tscn")
