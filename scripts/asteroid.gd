class_name Asteroid
extends RigidBody2D

@export var asteroid_speed = 250
@export var has_been_hooked = false
var initial_position: Vector2
var direction = Vector2(0, 1)
var previous_position: Vector2

func _ready() -> void:
	initial_position = self.position
	linear_velocity = direction * asteroid_speed

func _physics_process(delta: float) -> void:
	if has_been_hooked:
		linear_velocity = Vector2.ZERO  # Stop movement if hooked
	else:
		linear_velocity = direction * asteroid_speed

	# Reset if it goes too far
	if global_position.y > 2000:
		global_position = initial_position
		linear_velocity = direction * asteroid_speed
	
