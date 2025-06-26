extends BaseStateManager
class_name SpiderStateManager

func _ready() -> void:
	states = {
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

	initial_state = SpiderBaseState.State.Idle
