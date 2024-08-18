extends Node

class_name ThrowableComponent

const FOLLOW_SPEED = 10.0
const HOVER_OFFSET = Vector2(20, -10)

@export var throw_force: int = 100
@export var body: Node2D

signal throw_start
signal throw_done

@onready var player = get_tree().current_scene.get_node("Player")

func _ready() -> void:
	assert(body != null, "ThrowableComponent has missing body")
	assert(
		body is CharacterBody2D or
		body is StaticBody2D or
		body is AnimatableBody2D
	, "ThrowableComponent does not work on this body type!")

var picked_up := false
var throwing := false
var throw_to: Vector2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		pick_up()
	if event.is_action_pressed("shoot"):
		throw()
		

func _process(delta: float) -> void:
	if throwing:
		body.position = body.position.lerp(throw_to, delta * FOLLOW_SPEED)
		if (body.position - throw_to).length() < 1:
			throwing = false;
			throw_done.emit()
	elif picked_up:
		body.position = body.position.lerp(player.position + (HOVER_OFFSET * Vector2(player.get_facing_direction(), 1)), delta * FOLLOW_SPEED)
	


func disable_collision(): # todo: do properly.
	body.collision_mask = 0;
	body.collision_layer = 0;
	
func enable_collision(): #todo: do properly.
	body.collision_mask = 1;
	body.collision_layer = 1;

# player picks up item
func pick_up():
	throwing = false
	if picked_up == true:
		return put_down()
	disable_collision()
	picked_up = true
	
# player puts item down
func put_down():
	picked_up = false
	enable_collision()
	
# player throws item
func throw():
	if !picked_up: return
	put_down()
	var throw_direction = player.get_facing_direction()
	throwing = true;
	throw_to = Vector2(throw_force * throw_direction, 0) + player.position + HOVER_OFFSET
	throw_start.emit()
	pass
