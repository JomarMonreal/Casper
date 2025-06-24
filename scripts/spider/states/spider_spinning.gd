extends SpiderBaseState
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	spider.move()
	spider.rotation += delta * spider.ROTATION_SPEED
	return SpiderBaseState.State.Spinning
	
