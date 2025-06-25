extends SpiderBaseState

func input(event: InputEvent) -> int:
	
	if spider.hooking_obstacle():
		return SpiderBaseState.State.Spinning
		
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		return SpiderBaseState.State.Moving
	return SpiderBaseState.State.Idle
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	spider.move(delta)
	spider.rotation += delta
	return SpiderBaseState.State.Idle
	
