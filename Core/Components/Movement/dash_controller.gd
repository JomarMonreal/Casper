extends Node
class_name DashController

@export var dash_distance: float = 200.0
@export var dash_speed: float = 1500.0
@export var dash_scale: float = 0.5

var is_dashing := false
var is_on_cooldown := false
var initial_position: Vector2
var target_position: Vector2
var direction: Vector2
var controlled_body: PhysicsBody2D;

signal dash_start
signal dash_finished
signal cooldown_finished

@onready var cooldown_timer: Timer = $DashingCooldownTimer

func _ready():
	if owner is PhysicsBody2D:
		controlled_body = owner
	else:
		push_error("Dash Controller must be a child of a PhysicsBody2D node.")
	cooldown_timer.one_shot = true

func start_dash(direction_vector: Vector2):
	if is_dashing or is_on_cooldown:
		return

	initial_position = controlled_body.global_position
	direction = direction_vector.normalized()
	target_position = initial_position + direction * dash_distance

	is_dashing = true
	is_on_cooldown = true
	dash_start.emit()

func process_dash(delta: float):
	if not is_dashing:
		return

	var owner := get_parent() as CharacterBody2D
	var step = dash_speed * delta
	owner.global_position.x = move_toward(owner.global_position.x, target_position.x, step)
	owner.global_position.y = move_toward(owner.global_position.y, target_position.y, step)

	if owner.global_position.distance_to(target_position) < 1:
		is_dashing = false
		cooldown_timer.start()
		dash_finished.emit()
		
func _on_dashing_cooldown_timer_timeout() -> void:
	is_on_cooldown = false
	cooldown_timer.stop()
	cooldown_finished.emit()
