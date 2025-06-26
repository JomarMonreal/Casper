extends ObstacleBaseState

func enter() -> void:
	var obstacle := entity as Obstacle
	obstacle.freeze = true

func physics_process(delta: float) -> int:
	return ObstacleBaseState.State.Hooked
