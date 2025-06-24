extends CharacterBody2D
class_name Spider

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 6

var obstacles_incoming: Array[Obstacle] = []
var obstacle_hooked: Obstacle

@onready var states = $StateManager

func move() -> void:
		# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")

	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

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
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	var obstacle = body
	if obstacle is Obstacle:
		obstacles_incoming.append(obstacle)
		print("Obstacle entered:", obstacles_incoming)

func _on_area_2d_body_exited(body: Node2D) -> void:
	var obstacle = body
	if obstacle is Obstacle:
		obstacles_incoming.erase(obstacle)
		print("Obstacle exited:", obstacles_incoming)
