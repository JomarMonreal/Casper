extends SpiderBaseState

var oscillation_time = 0
var oscillation_speed = 5

func enter() -> void:
	var spider := entity as Spider
	spider.web_shoot_cooldown_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	spider.character_movement.move(delta)		
	oscillation_time += delta
	var scale = 0.1 * sin(oscillation_time * oscillation_speed) + 1
	spider.scale = Vector2(scale, scale)
	return SpiderBaseState.State.ReleasingWeb

func input(event: InputEvent) -> int:
	return SpiderBaseState.State.ReleasingWeb
