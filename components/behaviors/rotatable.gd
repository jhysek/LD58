
class_name Rotatable
extends BehaviorResource

var cursor = load("res://assets/cursor-6.png")
var drag = load("res://assets/drag-cursor.png")

var rotating = false
@export var sensitivity = 0.005

func on_grab_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_custom_mouse_cursor(drag)
			character.grab.dragging = true
			rotating = event.pressed

func on_input(event):
	if event is InputEventMouseButton:
		if !event.pressed:
			print("Setting normal cursor")
			Input.set_custom_mouse_cursor(cursor)
			character.grab.dragging = false
			rotating = false
			
	elif event is InputEventMouseMotion and rotating:
		var diff = (event.relative.x - event.relative.y) * sensitivity
		if character.rotation_parent != null:
			character.rotation_parent.rotation -= diff
		else:
			character.rotation -= diff
		
		rotate_binded(diff)
		character.on_changed()

func rotate_binded(diff):
	for elem in character.binded_elements:
		if elem.rotation_parent != null:
			elem.rotation_parent.rotation -= diff
		else:
			elem.rotation -= diff
