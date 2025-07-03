@tool
extends Node2D
class_name EnemySpawnerDebug

@onready var enemy_spawner: EnemySpawner = $".."
var runtime_settings: DebugRuntimeSettings = preload("res://Debug/debug_runtime_settings.tres")

var width: int = -1
var height: int = -1

func _enter_tree() -> void:
	DebugEditorSettings.show_debug_shapes_toggled.connect(on_show_debug_shapes_toggled)

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		process_mode = Node.PROCESS_MODE_DISABLED

	if enemy_spawner.width != width or enemy_spawner.height != height:
		width = enemy_spawner.width
		height = enemy_spawner.height
		queue_redraw()

func _draw() -> void:
	if not DebugEditorSettings.show_debug_shapes and Engine.is_editor_hint():
		return
	if not runtime_settings.show_debug_shapes_on_runtime and not Engine.is_editor_hint():
		return
	var text_size = ThemeDB.fallback_font.get_string_size("Enemy Spawn Area")
	draw_string(ThemeDB.fallback_font, Vector2(float(enemy_spawner.width)/2 - text_size.x/2,-float(enemy_spawner.height)/2), "Enemy Spawn Area")
	draw_rect(Rect2(0, 0, enemy_spawner.width, -enemy_spawner.height), Color(1,0,0,0.2))

func on_show_debug_shapes_toggled() -> void:
	queue_redraw()
