extends Area2D

var cursor = load("res://assets/cursor-6.png")
var grab = load("res://assets/grab.png")

func _on_mouse_entered() -> void:
	if !GlobalState.dragging:
		Input.set_custom_mouse_cursor(grab)

func _on_mouse_exited() -> void:
	if !GlobalState.dragging:
		Input.set_custom_mouse_cursor(cursor)
