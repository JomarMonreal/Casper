@tool
extends EditorPlugin

var debug_shapes_toggle_button: Button
var debug_shapes_toggle_on_runtime_button: Button
var runtime_settings: DebugRuntimeSettings

func _enter_tree() -> void:
    debug_shapes_toggle_button = CheckButton.new()
    debug_shapes_toggle_button.text = "Debug Shapes"
    debug_shapes_toggle_button.toggle_mode = true
    debug_shapes_toggle_button.button_pressed = DebugEditorSettings.show_debug_shapes
    debug_shapes_toggle_button.pressed.connect(_on_shapes_toggle_pressed)

    runtime_settings = load("res://Debug/debug_runtime_settings.tres")
    debug_shapes_toggle_on_runtime_button = CheckButton.new()
    debug_shapes_toggle_on_runtime_button.text = "Show on runtime"
    debug_shapes_toggle_on_runtime_button.toggle_mode = true
    debug_shapes_toggle_on_runtime_button.button_pressed = runtime_settings.show_debug_shapes_on_runtime
    debug_shapes_toggle_on_runtime_button.pressed.connect(_on_toggle_on_runtime_pressed)

    add_control_to_container(CONTAINER_TOOLBAR, debug_shapes_toggle_button)
    add_control_to_container(CONTAINER_TOOLBAR, debug_shapes_toggle_on_runtime_button)

func _exit_tree() -> void:
    if debug_shapes_toggle_button:
        remove_control_from_container(CONTAINER_TOOLBAR, debug_shapes_toggle_button)
        debug_shapes_toggle_button.queue_free()
        debug_shapes_toggle_button = null

    if debug_shapes_toggle_on_runtime_button:
        remove_control_from_container(CONTAINER_TOOLBAR, debug_shapes_toggle_on_runtime_button)
        debug_shapes_toggle_on_runtime_button.queue_free()
        debug_shapes_toggle_on_runtime_button = null

func _on_shapes_toggle_pressed():
    DebugEditorSettings.show_debug_shapes = debug_shapes_toggle_button.button_pressed

func _on_toggle_on_runtime_pressed():
    runtime_settings.show_debug_shapes_on_runtime = debug_shapes_toggle_on_runtime_button.button_pressed
    ResourceSaver.save(runtime_settings, "res://Debug/debug_runtime_settings.tres")