extends CharacterBody2D

@onready var sizeable_component: SizeableComponent = $SizeableComponent
@onready var regular: Sprite2D = %Regular

@export var SPEEDS = {"smol": 100, "regular": 200, "big": 300}
@export var JUMP_VELOCITIES = {"smol": -200, "regular": -300, "big": -400}

@export var start_size: int = 0


const COLLIDER_LERP_SPEED = 10.0

var JUMP_VELOCITY = 0
var SPEED = 0

const PUSH_FORCE = 75
const MAX_VELOCITY = 150

enum Direction {right = 1, left = -1}
var known_direction := Direction.right


var target_size_h = 10
var target_size_v = 50

signal node_ready

var instantiated = false
func _ready():
	node_ready.emit()
	instantiated = true
	sizeable_component.init(start_size)

func get_facing_direction():
	return known_direction
	
func make_size(res: SizeResource):
	JUMP_VELOCITY = JUMP_VELOCITIES.get(res.name)
	SPEED = SPEEDS.get(res.name)
	target_size_h = res.target_size_h
	target_size_v = res.target_size_v
	if not instantiated:
		await node_ready
	regular.set_texture(res.sprite)

func _on_sizeable_component_size(res) -> void:
	match res.name:
		"big": make_size(res)
		"regular": make_size(res)
		"smol": make_size(res)
		_: print_debug(res.name + "is not supported by player script!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test1"):
		sizeable_component.try_size_down()
	elif event.is_action_pressed("test2"):
		sizeable_component.try_size_up()

func size_up():
	sizeable_component.try_size_up()

func size_down():
	sizeable_component.try_size_down()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	%Collider.shape.height = lerp(%Collider.shape.height, float(target_size_v), delta * COLLIDER_LERP_SPEED)
		
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
