
class_name Rotatable
extends BehaviorResource

var cursor = load("res://assets/cursor-6.png")
var grab = load("res://assets/drag-cursor.png")

var rotating = false
@export var sensitivity = 0.005

func on_ready(parent):
	print("ready...")
	super(parent)
	rotating = false
	
func on_grab_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			GlobalState.set_dragging(true)
			Input.set_custom_mouse_cursor(grab)
			character.stop_sfx()
			rotating = event.pressed

func on_input(event):
	if event is InputEventMouseButton:
		if !event.pressed:
			GlobalState.set_dragging(false)
			Input.set_custom_mouse_cursor(cursor)
			rotating = false
			
	elif event is InputEventMouseMotion and rotating:
		var diff = (event.relative.x - event.relative.y) * sensitivity
		if character.rotation_parent != null:
			character.rotation_parent.rotation -= diff
		else:
			character.rotation -= diff
		
		if abs(diff) > 0:
			character.play_sfx()
		else:
			character.stop_sfx()
			
		rotate_binded(diff)
		character.on_changed()

func rotate_binded(diff):
	for elem in character.binded_elements:
		if elem.rotation_parent != null:
			elem.rotation_parent.rotation -= diff
		else:
			elem.rotation -= diff
