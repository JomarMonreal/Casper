extends Node2D
class_name ObstacleStateManager

@onready var states = {
	ObstacleBaseState.State.Moving: $Moving,
	ObstacleBaseState.State.Hooked: $Hooked,
	ObstacleBaseState.State.Destroyed: $Destroyed,
}

var current_state: ObstacleBaseState

func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()

func init(obstacle: Obstacle) -> void:
	for child in get_children():
		if child is ObstacleBaseState:
			child.obstacle = obstacle as Obstacle

	change_state(ObstacleBaseState.State.Moving)
	pass
	
func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != ObstacleBaseState.State.Null:
		change_state(new_state)
	
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state != ObstacleBaseState.State.Null:
		change_state(new_state)
		
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != ObstacleBaseState.State.Null:
		change_state(new_state)
