extends SpiderBaseState
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	if !is_instance_valid(spider.obstacle_hooked): return SpiderBaseState.State.Moving
	var obstacle_hooked = spider.obstacle_hooked
	
	spider.move(delta)
	spider.rotation += delta * spider.ROTATION_SPEED
	
	
	if InputMap.has_action("hook") and Input.is_action_just_released("hook"):
			
		for child in obstacle_hooked.get_children():
			if child is ObstacleStateManager:
				obstacle_hooked.reparent(get_tree().root)
				child.change_state(ObstacleBaseState.State.Moving)
		
		var direction_vector = (obstacle_hooked.global_position - obstacle_hooked.previous_position).normalized()
		obstacle_hooked.direction = direction_vector
		obstacle_hooked.asteroid_speed *= 2
		
		obstacle_hooked = null
		return SpiderBaseState.State.ReleasingWeb

	obstacle_hooked.previous_position = obstacle_hooked.global_position
	return SpiderBaseState.State.Spinning
	
