extends CharacterBody2D

@onready var throwable_component: ThrowableComponent = $ThrowableComponent
@onready var land: AudioStreamPlayer2D = $land
@onready var pickup: AudioStreamPlayer2D = $pickup
@onready var throw: AudioStreamPlayer2D = $throw


var pickupable = false
var shot = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if not pickupable: return
		throwable_component.pick_up()
		pickup.play()
	if event.is_action_pressed("shoot"):
		throwable_component.throw()
		throw.play()
		shot = true

func _physics_process(delta: float) -> void:
	
	if not throwable_component.picked_up and not throwable_component.throwing and not is_on_floor():
		velocity += get_gravity() * delta
	
	if shot && is_on_floor():
		shot = false
		land.play()
	
	
	move_and_slide()




func _on_area_2d_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pickupable = true;
	if body.name == "Platform layer" and throwable_component.throwing:
		throwable_component.stop_throw()


func _on_area_2d_trigger_body_exited(body: Node2D) -> void:
	pickupable = false;
