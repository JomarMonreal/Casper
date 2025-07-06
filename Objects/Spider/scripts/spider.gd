extends CharacterBody2D
class_name Spider

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 6

var obstacles_incoming: Array[Obstacle] = []
var obstacle_hooked: Obstacle
@onready var health_controller: HealthController = $HealthController
@onready var character_movement: TopDownCharacterMovement = $TopDownCharacterMovement
@onready var states: SpiderStateManager = $StateManager

@onready var main_sprite: Sprite2D = $SpiderSprite
@onready var dead_sprite: Sprite2D = $DeadSprite

var initial_sprite_scale: Vector2
@onready var dash_cooldown_timer: Timer = $DashingCooldownTimer
var is_dashing_cooldown = false

@onready var web_shoot_cooldown_timer: Timer = $WebShootCooldownTimer

@onready var shield_sprite: Sprite2D = $ShieldSprite
@onready var shield_cooldown_timer: Timer = $ShieldCooldownTimer
var is_shielding = false

func shield() -> void:
	if !is_shielding:
		shield_sprite.visible = true
		is_shielding = true
		shield_cooldown_timer.start()

func unshield() -> void:
	shield_sprite.visible = false 
	is_shielding = false
	shield_cooldown_timer.stop()
	
func hurt() -> void:
	dead_sprite.visible = true
	main_sprite.self_modulate.g = 0.5
	main_sprite.self_modulate.b = 0.5
	print("Player health: ", health_controller.health)
		
func unhurt() -> void:
	main_sprite.self_modulate.g = 1
	main_sprite.self_modulate.b = 1
	dead_sprite.visible = false

func hooking_obstacle() -> bool:
	if InputMap.has_action("hook") and Input.is_action_just_pressed("hook") and obstacles_incoming.size() > 0:
		# Find the closest asteroid
		var closest: Obstacle = obstacles_incoming[0]
		var closest_distance = closest.global_position.distance_to(global_position)

		for obstacle in obstacles_incoming:
			var dist = obstacle.global_position.distance_to(global_position)
			if dist < closest_distance:
				closest = obstacle
				closest_distance = dist


		obstacle_hooked = closest
		obstacles_incoming = []
		if is_instance_valid(obstacle_hooked):
			for child in closest.get_children():
				if child is ObstacleStateManager:
					obstacle_hooked.reparent(self)
					child.change_state(ObstacleBaseState.State.Hooked)
		else:
			print("Invalid obstacle when reparenting")
		return true
		
	return false

func _ready() -> void:
	initial_sprite_scale = main_sprite.scale
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	if InputMap.has_action("shield") and Input.is_action_just_released("shield"):
		shield()

	states.input(event)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	var obstacle = body
	if obstacle is Obstacle:
		obstacles_incoming.append(obstacle)

func _on_area_2d_body_exited(body: Node2D) -> void:
	var obstacle = body
	if obstacle is Obstacle:
		obstacles_incoming.erase(obstacle)

func _on_web_shoot_cooldown_timer_timeout() -> void:
	states.change_state(SpiderBaseState.State.Idle)
	web_shoot_cooldown_timer.stop()
	
func _on_shield_cooldown_timer_timeout() -> void:
	unshield()

func _on_dashing_cooldown_timer_timeout() -> void:
	is_dashing_cooldown = false
	dash_cooldown_timer.stop()
	
func _on_animal_can_take_damage() -> void:
	unhurt()

func _on_animal_damaged(amount: float) -> void:
	hurt()

func _on_animal_dead() -> void:
	states.change_state(SpiderBaseState.State.Dead)

func _on_health_controller_can_take_damage() -> void:
	unhurt()

func _on_health_controller_damaged(amount: float) -> void:
	hurt()

func _on_health_controller_dead() -> void:
	states.change_state(SpiderBaseState.State.Dead)
