extends Node
class_name ObstacleBaseState

enum State {
	Null,
	Moving,
	Hooked,
	Destroyed
}

var obstacle: Obstacle

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func input(event: InputEvent) -> int:
	return State.Null
	
func process(delta: float) -> int:
	return State.Null
		
func physics_process(delta: float) -> int:
	return State.Null
