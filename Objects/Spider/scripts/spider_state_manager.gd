extends Node2D
class_name SpiderStateManager

@onready var states = {
	SpiderBaseState.State.Idle: $Idle,
	SpiderBaseState.State.Moving: $Moving,
	SpiderBaseState.State.ShootingWeb: $ShootingWeb,
	SpiderBaseState.State.Spinning: $Spinning,
	SpiderBaseState.State.ReleasingWeb: $ReleasingWeb,
	SpiderBaseState.State.Shielding: $Shielding,
	SpiderBaseState.State.Dashing: $Dashing,
	SpiderBaseState.State.Hurt: $Hurt,
	SpiderBaseState.State.Dead: $Dead,
}

var current_state: SpiderBaseState

func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()

func init(spider: Spider) -> void:
	for child in get_children():
		if child is SpiderBaseState:
			child.spider = spider as Spider

	change_state(SpiderBaseState.State.Idle)
	
func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != SpiderBaseState.State.Null:
		change_state(new_state)
	
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state != SpiderBaseState.State.Null:
		change_state(new_state)
		
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != SpiderBaseState.State.Null:
		change_state(new_state)
