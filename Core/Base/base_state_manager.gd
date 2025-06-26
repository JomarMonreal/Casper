extends Node
class_name BaseStateManager

var states = {}
var initial_state: int
var current_state: BaseState

func change_state(new_state: int) -> void:
	if current_state == states[new_state]:
		return # Don't change to the same state
	
	if current_state:
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()

func init(entity: Node) -> void:
	for child in get_children():
		if child is BaseState:
			child.entity = entity

	change_state(initial_state)
	
func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != BaseState.STATE_NULL:
		change_state(new_state)
	
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state != BaseState.STATE_NULL:
		change_state(new_state)
		
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != BaseState.STATE_NULL:
		change_state(new_state)
