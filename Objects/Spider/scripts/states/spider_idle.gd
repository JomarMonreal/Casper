extends SpiderBaseState

func input(event: InputEvent) -> int:
	var spider := entity as Spider
	if spider.hooking_obstacle():
		return SpiderBaseState.State.Spinning
		
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		return SpiderBaseState.State.Moving
	return SpiderBaseState.State.Idle
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	spider.character_movement.move(delta)
	spider.rotation += delta
	if InputMap.has_action("dash") and Input.is_action_just_released("dash") and !spider.is_dashing_cooldown:
		return SpiderBaseState.State.Dashing
	return SpiderBaseState.State.Idle
	
