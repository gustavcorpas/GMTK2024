extends Node2D

class_name Portal

enum Augmentation_Mode {
	left_to_right = 1,
	right_to_left = -1
}

enum Direction {
	left_to_right = 1, right_to_left = -1
}

enum State {
	disabled, enabled
}

@export var sprite: AnimatedSprite2D

@export var LeftArea2D: Area2D
@export var RightArea2D: Area2D

@export var diminish_sound: AudioStreamPlayer2D
@export var augment_sound: AudioStreamPlayer2D

@export var max_emit_count: int = -1
@export var effect_activator: bool = false
@export var augmentation_mode: Augmentation_Mode = Augmentation_Mode.left_to_right
@export var connections: Array[Node2D] = []


signal augment
signal diminish
signal disabled

var usage_count = 0
var state: State = State.enabled

var on_left: bool = false
var on_right: bool = false

func _ready() -> void:
	LeftArea2D.body_entered.connect(_on_left_area_body_entered)
	LeftArea2D.body_exited.connect(_on_left_area_body_exited)
	RightArea2D.body_entered.connect(_on_right_area_body_entered)
	RightArea2D.body_exited.connect(_on_right_area_body_exited)
	
	if augmentation_mode == Augmentation_Mode.right_to_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
func flip():
	augmentation_mode *= -1
	if augmentation_mode == Augmentation_Mode.right_to_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func disable():
	state = State.disabled
	disabled.emit()

func emit(direction: Direction, body: Node2D):
	if state == State.disabled:
		return
	usage_count += 1;
	var mod = direction * augmentation_mode
	if mod == 1:
		augment.emit(body)
		augment_sound.play()
		print_debug("augment!");
	elif mod == -1:
		diminish.emit(body)
		diminish_sound.play()
		print_debug("diminish!");
	
	if max_emit_count < 0: 
		return # disable max emit count
	if usage_count >= max_emit_count:
		disable()
	

func _on_left_area_body_entered(body: Node2D) -> void:
	on_left = true;


func _on_left_area_body_exited(body: Node2D) -> void:
	on_left = false;
	if on_right == true:
		emit(Direction.left_to_right, body)
	
	

func _on_right_area_body_entered(body: Node2D) -> void:
	on_right = true;



func _on_right_area_body_exited(body: Node2D) -> void:
	on_right = false
	if on_left == true:
		emit(Direction.right_to_left, body)
