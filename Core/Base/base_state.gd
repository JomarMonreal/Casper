extends Node
class_name BaseState

static var STATE_NULL: int = 0

var entity: Node

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func input(_event: InputEvent) -> int:
	return STATE_NULL 
	
func process(_delta: float) -> int:
	return STATE_NULL
		
func physics_process(delta: float) -> int:
	return STATE_NULL
