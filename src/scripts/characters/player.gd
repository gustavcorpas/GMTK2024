extends CharacterBody2D


const SPEED = 300.0
@export var JUMP_VELOCITY = -400.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	var big = preload("res://assets/art/BigAlien.png")
	var reg = preload("res://assets/art/RegAlien.png")
	var smol = preload("res://assets/art/MiniAlien.png")
	
	if Input.is_action_just_pressed("test1"):
		%Collider.shape.height = 14
		%Regular.texture = smol
		JUMP_VELOCITY = -200.0
	if Input.is_action_just_pressed("test2"):
		%Collider.shape.height = 30
		%Regular.texture = reg
		JUMP_VELOCITY = -300.0
	if Input.is_action_just_pressed("test3"):
		%Collider.shape.height = 46
		%Regular.texture = big
		JUMP_VELOCITY = -400.0
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
