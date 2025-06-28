extends ObstacleBaseState

func enter() -> void:
	var obstacle := entity as Obstacle
	obstacle.death_timer.start()
	obstacle.sleeping = true

func physics_process(delta: float) -> int:
	return ObstacleBaseState.State.Destroyed
