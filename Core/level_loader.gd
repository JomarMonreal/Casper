class_name LevelLoader
extends Node

@export var level_container: Node

func load_level(level_path: String):
	# If level exists
	if not ResourceLoader.exists(level_path):
		push_error(("Level scene not found: " + level_path))
		return

	# Remove current level
	for child in level_container.get_children():
		child.queue_free()

	# Load and add new level
	var new_level = load(level_path).instantiate()
	level_container.add_child(new_level)
