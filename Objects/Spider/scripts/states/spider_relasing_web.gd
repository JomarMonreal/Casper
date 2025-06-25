extends SpiderBaseState

var oscillation_time = 0
var oscillation_speed = 5

func enter() -> void:
	spider.skill_cooldown_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	spider.move(delta)		
	oscillation_time += delta
	var scale = 0.1 * sin(oscillation_time * oscillation_speed) + 1
	spider.scale = Vector2(scale, scale)
	return SpiderBaseState.State.ReleasingWeb

	
func input(event: InputEvent) -> int:
	return SpiderBaseState.State.ReleasingWeb


func _on_skill_cooldown_timer_timeout() -> void:
	print("COOL")
	spider.states.change_state(SpiderBaseState.State.Idle)
	spider.skill_cooldown_timer.stop()
