extends ObstacleBaseState

func enter() -> void:
	var obstacle := entity as Obstacle
	obstacle.freeze = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var obstacle := entity as Obstacle
	obstacle.linear_velocity = obstacle.direction * obstacle.asteroid_speed

	# Reset if it goes too far
	if obstacle.global_position.y > 1500 or obstacle.global_position.y < -1500:
		obstacle.global_position.y *= -1
	if obstacle.global_position.x > 2500 or obstacle.global_position.x < -2500:
		obstacle.global_position.x *=- 1	
	
	return ObstacleBaseState.State.Moving
