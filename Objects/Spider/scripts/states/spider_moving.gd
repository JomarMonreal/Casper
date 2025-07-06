extends SpiderBaseState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	spider.character_movement.move(delta)		
	
	if spider.velocity.x == 0 and spider.velocity.y == 0:
		return SpiderBaseState.State.Idle
		
	return SpiderBaseState.State.Moving

	
func input(event: InputEvent) -> int:
	var spider := entity as Spider
	if spider.hooking_obstacle():
		return SpiderBaseState.State.Spinning
	if InputMap.has_action("dash") and Input.is_action_just_released("dash") and !spider.is_dashing_cooldown:
		return SpiderBaseState.State.Dashing

	return SpiderBaseState.State.Moving
