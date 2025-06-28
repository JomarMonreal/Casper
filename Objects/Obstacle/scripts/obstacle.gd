class_name Obstacle
extends RigidBody2D

@export var asteroid_speed = 250
var initial_position: Vector2
var direction = Vector2(0, 1)
var previous_position: Vector2

var death_timer: Timer
var obstacle_collided: Obstacle

@onready var states = $StateManager

func _ready() -> void:
	initial_position = self.position
	death_timer = $DeathTimer
	linear_velocity = direction * asteroid_speed
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_body_entered(body: Node) -> void:
	if body is Obstacle:
		states.change_state(ObstacleBaseState.State.Destroyed)
		body.states.change_state(ObstacleBaseState.State.Destroyed)


func _on_death_timer_timeout() -> void:
	death_timer.stop()
	queue_free()
	return
