# Throwable

The throwable component works with the following nodes:

- `CharacterBody2D`
- `StaticBody2D`
- `AnimatableBody2D`

It makes available the following methods:

- `pick_up` - Will pickup and carry around the object.
- `put_down` - Will stop carrying it.
- `throw` - Will throw it a certain distance.

Calling `pick_up` if already carrying will instead call `put_down`.

Also you may listen to two signals

- `throw_start`
- `throw_done`

Example:
	
```
@export var throwable: ThrowableComponent

func _input(event: InputEvent) -> void:
	# check if is in range ...
	if event.is_action_pressed("interact"):
		throwable.pick_up()
	if event.is_action_pressed("shoot"):
		throwable.throw()
```
