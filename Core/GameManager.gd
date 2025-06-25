extends Node

@export var level_loader: LevelLoader

func _ready() -> void:
	level_loader.load_level("uid://h8ksfshtgrq1")
