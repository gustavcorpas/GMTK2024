# Portals

__Augmentation Mode__: The direction of the portal.
Can be set from the inspector.

__Connections__: A list of nodes that will be trickered when the portal is activated.

### Portal Types

__BaseClass__: All portals has these signals:
	- augment - the portal is encreasing
	- diminish - the portal is diminishing
	- disabled - the portal has been disabled
	
You can specify a non-negative `max emit count` to have the portal be disabled after x-amount of uses.

You can flip the direction of a portal by calling the `flip()` function.

Enabling `Effect Activator` will send augment / diminish signals to the activator also.
It is up to specific portal types to implement this though!

__SizePortal__: The size portal will size connected nodes.
The nodes must have `func size_up` and `func size_down` methods for this to work!

You can use the SizableComponent node to get access to nice default functionality for sizing behaviour.
You may import the compoent like so: `@export var size_component: SizeableComponent`.
You can then select the node from the inspector and use the functions in your scene scripts.


### Creating new portal types

Make your portal extend from the Portal base class: `extends Portal`.
Then add the `Left Area 2D` and `Right Area 2D` nodes in the inspector.

You can listen to the signals of the base class like so:
(body is the element that caused the activation)

```
func _on_augment(body) -> void:
	print_debug("augment!", body);
```
