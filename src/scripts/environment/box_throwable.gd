extends CharacterBody2D

@onready var throwable_component: ThrowableComponent = $ThrowableComponent

var pickupable = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if not pickupable: return
		throwable_component.pick_up()
	if event.is_action_pressed("shoot"):
		throwable_component.throw()

func _physics_process(delta: float) -> void:
	
	if not throwable_component.picked_up and not throwable_component.throwing and not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()




func _on_area_2d_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pickupable = true;


func _on_area_2d_trigger_body_exited(body: Node2D) -> void:
	pickupable = false;
