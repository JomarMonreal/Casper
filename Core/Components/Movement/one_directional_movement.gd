extends Node
class_name OneDirectionalMovement

@export var speed: float = 200.0
@export var is_randomized = true
@export var direction = Vector2(0, 1)

var controlled_body: RigidBody2D

func _ready() -> void:
	if owner is RigidBody2D:
		controlled_body = owner
		if is_randomized:
			var angle = randf_range(0, TAU) # TAU = 2 * PI
			direction = Vector2(cos(angle), sin(angle)).normalized()
	else:
		push_error("OneDirectionalMovement must be a child of a RigidBody2D node.")

func move(delta: float) -> void:
	if controlled_body:
		controlled_body.linear_velocity = direction * speed
		
