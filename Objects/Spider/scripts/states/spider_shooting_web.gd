extends SpiderBaseState


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	spider.move(delta)
	
	if spider.velocity.x == 0 and spider.velocity.y == 0:
		return SpiderBaseState.State.Idle
		
	return SpiderBaseState.State.Moving
	
	
