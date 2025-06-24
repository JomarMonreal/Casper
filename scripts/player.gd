@tool
class_name Player
extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
var is_spinning = false
var rotation_speed = 8
var is_hooking_on_cooldown = false
var hook_cooldown_timer: Timer
var hook_radius = 150
var obstacles_incoming: Array[Obstacle] = []
var obstacle_hooked: Obstacle

func _ready() -> void:
	hook_cooldown_timer = $Timer

func _process(delta: float) -> void:
	if is_hooking_on_cooldown: return
	
	if is_instance_valid(obstacle_hooked):
		var distance = obstacle_hooked.global_position.distance_to(global_position)
		if distance > hook_radius:
			print(distance)
			obstacle_hooked.global_position = obstacle_hooked.global_position.move_toward(global_position, delta * SPEED)


		rotation += delta * rotation_speed
		if InputMap.has_action("hook") and Input.is_action_just_released("hook"):
			obstacle_hooked.reparent(get_tree().root)
			obstacle_hooked.has_been_hooked = false
			
			var direction_vector = (obstacle_hooked.global_position - obstacle_hooked.previous_position).normalized()
			obstacle_hooked.direction = direction_vector
			obstacle_hooked.asteroid_speed *= 2
			
			obstacle_hooked = null
			is_hooking_on_cooldown = true
			hook_cooldown_timer.start()
			return

		obstacle_hooked.previous_position = obstacle_hooked.global_position
	elif obstacle_hooked:
		obstacle_hooked = null
		hook_cooldown_timer.start()
			
	if InputMap.has_action("hook") and Input.is_action_just_pressed("hook"):
		if obstacles_incoming.size() > 0:
			# Find the closest asteroid
			var closest: Obstacle = obstacles_incoming[0]
			var closest_distance = closest.global_position.distance_to(global_position)

			for asteroid in obstacles_incoming:
				var dist = asteroid.global_position.distance_to(global_position)
				if dist < closest_distance:
					closest = asteroid
					closest_distance = dist

			obstacle_hooked = closest
			obstacles_incoming = []
			obstacle_hooked.has_been_hooked = true
			obstacle_hooked.reparent(self)	
	

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
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
		
	if is_spinning:
		print(rotation_speed)
		rotation += delta * rotation_speed

	move_and_slide()


func _on_timer_timeout() -> void:
	is_hooking_on_cooldown = false
	obstacle_hooked = null
	hook_cooldown_timer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if obstacle_hooked or is_hooking_on_cooldown: return

	var asteroid = body
	if asteroid is Obstacle and asteroid not in obstacles_incoming:
		obstacles_incoming.append(asteroid)
		print("Obstacle entered:", obstacles_incoming)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if obstacle_hooked or is_hooking_on_cooldown: return

	var asteroid = body
	if asteroid is Obstacle and asteroid in obstacles_incoming:
		obstacles_incoming.erase(asteroid)
		print("Obstacle exited:", obstacles_incoming)
