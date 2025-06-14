class_name Asteroid
extends RigidBody2D

@export var asteroid_speed = 250
@export var has_been_hooked = false
var initial_position: Vector2
var direction = Vector2(0, 1)
var previous_position: Vector2
var death_timer: Timer
var asteroid_collided: Asteroid

func _ready() -> void:
	initial_position = self.position
	death_timer = $Timer
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
	

func destroy_nodes() -> void:
	if is_instance_valid(asteroid_collided):
		asteroid_collided.queue_free()
	if is_instance_valid(self):
		queue_free()
		death_timer.stop()

func _on_body_entered(body: Node) -> void:
	if body is Asteroid:
		asteroid_collided = body
		death_timer.start()


func _on_timer_timeout() -> void:
	destroy_nodes()
	
