extends Node
class_name RaycastBounceController

@export var raycast: RayCast2D
@export var movement: Node 
@export var entity: Node2D
@export var movement_offset: int = 5
@export var raycast_distance: float = 70

func update_bounce_direction() -> void:
	if raycast and raycast.is_colliding():
		var new_y = movement.direction.y + randi_range(-movement_offset, movement_offset)
		var new_x = movement.direction.x + randi_range(-movement_offset, movement_offset)
		var new_direction = Vector2(-new_x, -new_y).normalized()
		movement.direction = new_direction

		var global_target = entity.global_position + new_direction * raycast_distance
		raycast.target_position = raycast.to_local(global_target)
