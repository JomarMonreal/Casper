@tool
extends Node

signal show_debug_shapes_toggled()

var show_debug_shapes: bool = false:
    set(new_state):
        show_debug_shapes = new_state
        emit_signal("show_debug_shapes_toggled")
