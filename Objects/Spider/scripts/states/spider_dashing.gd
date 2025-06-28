extends SpiderBaseState

var oscillation_time = 0
var oscillation_speed = 5
var dashing_scale = 0.5
var initial_position: Vector2
var target_position: Vector2
@export var dash_distance = 200

func enter() -> void:
	var spider := entity as Spider
	initial_position = spider.global_position
	target_position = initial_position + (spider.last_direction * dash_distance)
	spider.main_sprite.scale =  spider.initial_sprite_scale * dashing_scale
	spider.is_dashing_cooldown = true
	spider.dash_cooldown_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> int:
	var spider := entity as Spider
	
	var step = 1500 * delta
	spider.global_position.x = move_toward(spider.global_position.x, target_position.x, step)
	spider.global_position.y = move_toward(spider.global_position.y, target_position.y, step)

	if spider.global_position.distance_to(target_position) < 0.1:
		spider.main_sprite.scale = spider.initial_sprite_scale
		return SpiderBaseState.State.Idle
	return SpiderBaseState.State.Dashing
