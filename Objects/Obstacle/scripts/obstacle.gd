class_name Obstacle
extends RigidBody2D

var initial_position: Vector2
var previous_position: Vector2

var death_timer: Timer
var obstacle_collided: Obstacle

@export var raycast_distance = 70

@onready var states: ObstacleStateManager = $StateManager
@onready var movement: OneDirectionalMovement = $OneDirectionalMovement

func _ready() -> void:
	initial_position = self.position
	death_timer = $DeathTimer
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_body_entered(body: Node) -> void:
	if body is Spider:
		body.health_controller.take_damage(10)
		return
	if body is Obstacle:
		body.states.change_state(ObstacleBaseState.State.Destroyed)
	states.change_state(ObstacleBaseState.State.Destroyed)
		
func _on_death_timer_timeout() -> void:
	death_timer.stop()
	queue_free()
	return
