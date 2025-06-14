extends Node2D

@export var asteroid_node = preload("res://scenes/asteroid.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var asteroid_count = randi_range(20, 30)
	for i in range(asteroid_count):
		var delay = randf_range(1, 15)  # Each asteroid gets its own delay
		spawn_asteroid_after_delay(delay)

func spawn_asteroid_after_delay(delay: float) -> void:
	# Start a coroutine to spawn after delay
	await get_tree().create_timer(delay).timeout
	var asteroid = asteroid_node.instantiate()
	asteroid.position = Vector2(randi_range(100, 1000), 0)
	add_child(asteroid)
