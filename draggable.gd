class_name Draggable
extends BehaviorResource

@export var max_limit = 100
@export var min_limit = -100
@export var sensitivity = 1.0

var dragging = false
var direction = Vector2(1, 0) 
var start_position: Vector2

func on_ready(parent):
	super(parent)
	start_position = character.global_position

func on_grab_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed

func on_input(event):
	if event is InputEventMouseButton and !event.pressed:
		dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = event.relative
		var projected_amount = delta.dot(direction.normalized()) * sensitivity

		var new_position = character.global_position + direction.normalized() * projected_amount
		var offset_vector = new_position - start_position
		var offset_amount = offset_vector.dot(direction.normalized())

		offset_amount = clamp(offset_amount, min_limit, max_limit)

		character.global_position = start_position + direction.normalized() * offset_amount
		character.on_changed()
