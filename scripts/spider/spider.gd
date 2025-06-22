extends CharacterBody2D
class_name Spider

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 8

@onready var states = $StateManager

func _ready() -> void:
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
