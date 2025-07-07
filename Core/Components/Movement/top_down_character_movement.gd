extends Node
class_name TopDownCharacterMovement

@export var speed: float = 500.0
var last_direction := Vector2.ZERO
var velocity := Vector2.ZERO
var controlled_body: CharacterBody2D

func _ready() -> void:
	if owner is CharacterBody2D:
		controlled_body = owner
	else:
		push_error("TopDownCharacterMovement must be a child of a CharacterBody2D node.")

func move(delta: float) -> void:
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	if x_direction:
		velocity.x = x_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if y_direction:
		velocity.y = y_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if velocity != Vector2.ZERO:
		last_direction = Vector2(x_direction, y_direction)

	if controlled_body:
		controlled_body.velocity = velocity
		controlled_body.move_and_slide()

func get_last_direction() -> Vector2:
	return last_direction

func get_velocity() -> Vector2:
	return velocity
