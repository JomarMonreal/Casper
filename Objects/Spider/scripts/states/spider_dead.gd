extends SpiderBaseState

var oscillation_time = 0
var oscillation_speed = 5

signal spider_dead

func enter() -> void:
	var spider := entity as Spider

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	if oscillation_time > 8:
		spider_dead.emit()
		spider.main_sprite.visible = false
		spider.dead_sprite.visible = true
		return SpiderBaseState.State.Dead
		
	oscillation_time += delta * oscillation_speed
	
	spider.main_sprite.self_modulate.g = 0.5 * sin(oscillation_time * (PI/2)) + 0.5
	spider.main_sprite.self_modulate.b = 0.5 * sin(oscillation_time * (PI/2)) + 0.5
	
	

	
	return SpiderBaseState.State.Dead
