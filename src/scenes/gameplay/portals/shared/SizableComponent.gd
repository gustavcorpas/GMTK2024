extends Node2D

class_name SizeableComponent

@export var sizes: Array[SizeResource] = []
@export var current_size_index := 0

@export var exlude_layers: Array[int] = []
@export var debug_mode: bool = false

const PADDING = 10

signal size

var ray_up: RayCast2D
var ray_down: RayCast2D
var ray_left: RayCast2D
var ray_right: RayCast2D

var line_up: Line2D
var line_down: Line2D
var line_left: Line2D
var line_right: Line2D

enum Colliding {left, up, right, down}
var colliding = [0, 0, 0, 0]	

func init(size_index):
	current_size_index = size_index
	size.emit(sizes[current_size_index])

func create_ray():
	var ray = RayCast2D.new()
	for layer in exlude_layers:
		ray.set_collision_mask_value(layer, false)
	add_child(ray)
	return ray
	
func create_line():		
	var line = Line2D.new()
	line.width = 1
	add_child(line)
	return line
	
func process_ray(ray: RayCast2D, line, target: Vector2, on_collision):
	ray.target_position = target
	if ray.is_colliding():
		var collider = ray.get_collider()
		on_collision.call(collider)
		
	if debug_mode:
		line.points = [ray.position, ray.target_position]

func _ready():
	ray_up = create_ray()
	ray_down = create_ray()
	ray_right = create_ray()
	ray_left = create_ray()
	line_up = create_line()
	line_down = create_line()
	line_left = create_line()
	line_right = create_line()
	

func _process(delta: float):
	if not debug_mode: return
	colliding = [0, 0, 0, 0]
	var current_size = sizes[current_size_index]
	process_ray(ray_up, line_up, Vector2(0, -current_size.target_size_v * 2 - PADDING), func up(col): colliding[Colliding.up] = 1)
	process_ray(ray_down, line_down, Vector2(0, current_size.target_size_v * 2 + PADDING), func up(col): colliding[Colliding.down] = 1)
	
	process_ray(ray_left, line_left, Vector2(-current_size.target_size_h * 2 - PADDING, 0), func up(col): colliding[Colliding.left] = 1)
	process_ray(ray_right, line_right, Vector2(current_size.target_size_h * 2 + PADDING, 0), func up(col): colliding[Colliding.right] = 1)

func try_size_up():
	if not valid_state_change(1): return
	if not can_scale_in_space(1): return
	current_size_index += 1
	size.emit(sizes[current_size_index])
	
func try_size_down():
	if not valid_state_change(-1): return
	current_size_index -= 1
	size.emit(sizes[current_size_index])


func valid_state_change(change: int):
	var new_size = current_size_index + change
	if new_size < 0: return false
	if new_size >= sizes.size(): return false
	return true
	
func can_scale_in_space(change: int):
	var target = sizes[current_size_index + change]
	if not can_scale_in_space_h(target): return false
	if not can_scale_in_space_v(target): return false
	return true

func can_scale_in_space_h(target: SizeResource):
	var colliding = [0, 0, 0, 0]
	process_ray(ray_left, line_left, Vector2(-target.target_size_h * 2 - PADDING, 0), func up(col): colliding[Colliding.left] = 1)
	process_ray(ray_right, line_right, Vector2(target.target_size_h * 2 + PADDING, 0), func up(col): colliding[Colliding.right] = 1)
	if colliding[Colliding.left] && colliding[Colliding.right]: return false
	return true
	
func can_scale_in_space_v(target: SizeResource):
	var colliding = [0, 0, 0, 0]
	process_ray(ray_up, line_up, Vector2(0, -target.target_size_v * 2 - PADDING), func up(col): colliding[Colliding.up] = 1)
	process_ray(ray_down, line_down, Vector2(0, target.target_size_v * 2 + PADDING), func up(col): colliding[Colliding.down] = 1)
	if colliding[Colliding.down] && colliding[Colliding.up]: return false
	return true
