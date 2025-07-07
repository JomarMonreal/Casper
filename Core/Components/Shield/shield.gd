extends Node2D
class_name Shield

@onready var shield_sprite: Sprite2D = $ShieldSprite
@onready var shield_cooldown_timer: Timer = $ShieldCooldownTimer
var is_shielding = false

signal on_shield_start
signal on_shield_down

func open() -> void:
	if !is_shielding:
		shield_sprite.visible = true
		is_shielding = true
		shield_cooldown_timer.start()
		on_shield_start.emit()

func close() -> void:
	shield_sprite.visible = false 
	is_shielding = false
	shield_cooldown_timer.stop()
	on_shield_down.emit()


func _on_shield_cooldown_timer_timeout() -> void:
	close()
