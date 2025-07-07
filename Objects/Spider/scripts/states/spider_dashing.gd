extends SpiderBaseState

var dashing_scale = 0.5
@export var dash_distance = 200

func enter() -> void:
	var spider := entity as Spider
	spider.dash_controller.start_dash(spider.character_movement.last_direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	spider.dash_controller.process_dash(delta)
	if !spider.dash_controller.is_dashing:
		return SpiderBaseState.State.Idle
	return SpiderBaseState.State.Dashing


func _on_dash_controller_dash_finished() -> void:
	var spider := entity as Spider
	spider.states.change_state(SpiderBaseState.State.Idle)
