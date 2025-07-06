class_name HealthController
extends Node2D

@export var health = 100
@export var damage = 10
@export var speed = 500
var is_hurt = false

@onready var hurt_cooldown_timer: Timer = $HurtCooldownTimer

signal damaged(amount: float)
signal can_take_damage
signal dead

func take_damage(amount: float)->void:
	if !is_hurt:
		health -= amount
		
		if health <= 0:
			dead.emit()
			return
			
		damaged.emit(amount)
		is_hurt = true
		hurt_cooldown_timer.start()


func _on_hurt_cooldown_timer_timeout() -> void:
	is_hurt = false
	can_take_damage.emit()
	hurt_cooldown_timer.stop()
