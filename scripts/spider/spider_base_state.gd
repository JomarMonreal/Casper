extends Node
class_name SpiderBaseState

enum State {
	Null,
	Idle,
	Moving,
	ShootingWeb,
	Spinning,
	ReleasingWeb,
	Shielding,
	Dashing,
	Hurt,
	Dead
}

var spider: Spider

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
