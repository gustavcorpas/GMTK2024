extends CharacterBody2D

@onready var sizeable_component: SizeableComponent = $SizeableComponent

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -400.0

const PUSH_FORCE = 75
const MAX_VELOCITY = 150

enum Direction {right = 1, left = -1}
var known_direction := Direction.right

var big = preload("res://assets/art/BigAlien.png")
var reg = preload("res://assets/art/RegAlien.png")
var smol = preload("res://assets/art/MiniAlien.png")


func get_facing_direction():
	return known_direction

func make_smol():
	pass
	# %Collider.shape.height = 14
	# %Regular.texture = smol
	# JUMP_VELOCITY = -200.0
	
func make_regular():
	pass
	# %Collider.shape.height = 30
	# %Regular.texture = reg
	# JUMP_VELOCITY = -300.0

func make_big():
	pass
	# %Collider.shape.height = 46
	# %Regular.texture = big
	# JUMP_VELOCITY = -400.0
	
func _on_sizeable_component_size(res) -> void:
	print("got: " + res.name)
	return
	match res.name:
		"big": make_big()
		"regular": make_regular()
		"smol": make_smol()
		_: print_debug(res.name + "is not supported by player script!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test1"):
		sizeable_component.try_size_down()
	elif event.is_action_pressed("test2"):
		sizeable_component.try_size_up()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
		
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
		if direction > 0:
			known_direction = Direction.right
		elif direction < 0:
			known_direction = Direction.left
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_crate = collision.get_collider()
		if collision_crate.is_in_group("crates") and abs(collision_crate.get_linear_velocity().x) < MAX_VELOCITY:
			collision_crate.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
	
	move_and_slide()
