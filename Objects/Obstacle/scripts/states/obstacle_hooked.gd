extends ObstacleBaseState

func enter() -> void:
	obstacle.freeze = true
	print("HOOKED")

func physics_process(delta: float) -> int:
	return ObstacleBaseState.State.Hooked
