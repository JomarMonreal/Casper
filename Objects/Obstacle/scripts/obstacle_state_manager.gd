extends BaseStateManager
class_name ObstacleStateManager

func _ready() -> void:
	states = {
		ObstacleBaseState.State.Moving: $Moving,
		ObstacleBaseState.State.Hooked: $Hooked,
		ObstacleBaseState.State.Destroyed: $Destroyed,
	}

	initial_state = ObstacleBaseState.State.Moving
