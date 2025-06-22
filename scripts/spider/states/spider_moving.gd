extends SpiderBaseState


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	if x_direction:
		spider.velocity.x = x_direction * spider.SPEED
	else:
		spider.velocity.x = move_toward(spider.velocity.x, 0, spider.SPEED)

	if y_direction:
		spider.velocity.y = y_direction * spider.SPEED
	else:
		spider.velocity.y = move_toward(spider.velocity.y, 0, spider.SPEED)
	
	spider.move_and_slide()
	
	if spider.velocity.x == 0 and spider.velocity.y == 0:
		return SpiderBaseState.State.Idle
		
	return SpiderBaseState.State.Moving
