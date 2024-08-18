# Components

Components are reusable scripts you may attach and setup to a node to enable easy access to certain functionality.

```
@export var component: ExampleComponent
component.do_something()
```

## Sizeable

The sizeable component has two relevant methods:

- `try_size_up`
- `try_size_down`

It takes an array of `SizeResource`s and determines if a transition is possible.

The scene may then listen to the `size` event, to get informed about actual possible changes. 
It is up to the parent object to handle actual resizing,
but it may use the relevant `SizeResource` that is returned in the `size` event.

__OBS: The base for calculations is the `transform` of the `SizeableComponent`__

Example:

```

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test1"):
		sizeable_component.try_size_down()
	if event.is_action_pressed("test2"):
		sizeable_component.try_size_up()
		

func _on_sizeable_component_size(res) -> void:
	print_debug("sizing", res)


```

## Throwable

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
