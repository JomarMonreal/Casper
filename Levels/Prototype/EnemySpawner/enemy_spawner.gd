extends Node2D
class_name EnemySpawner

@onready var debug: EnemySpawnerDebug = $Debug
@onready var spawn_ticker: Timer = $SpawnTicker
var enemy_container: Node2D

@export_range(0,500) var width: int
@export_range(0,500) var height: int
@export var spawnables: Array[Spawnable]
@export var spawn_tick_rate: float = 0.5

var is_enabled: bool = true

func _ready() -> void:
    spawn_ticker.wait_time = spawn_tick_rate
    spawn_ticker.timeout.connect(_on_spawn_ticker_timeout)
    spawn_ticker.start()
    enemy_container = get_tree().get_first_node_in_group("ENEMY_CONTAINER")

func _on_spawn_ticker_timeout() -> void:
    for spawnable in spawnables:
        if randf() < spawnable.spawn_rate:
            var spawnable_instance = spawnable.spawnable.instantiate() as Node2D
            var offset = Vector2(randi() % width, randi() % height)
            var new_position = Vector2(global_position.x + offset.x, global_position.y - offset.y)
            spawnable_instance.global_position = new_position
            enemy_container.add_child(spawnable_instance)