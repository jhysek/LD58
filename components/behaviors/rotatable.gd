
class_name Rotatable
extends BehaviorResource

var rotating = false
@export var sensitivity = 0.005

func on_grab_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			rotating = event.pressed

func on_input(event):
	if event is InputEventMouseButton:
		if !event.pressed:
			rotating = false
			
	elif event is InputEventMouseMotion and rotating:
		var diff = (event.relative.x - event.relative.y) * sensitivity
		character.rotation -= diff
		
		rotate_binded(diff)
		character.on_changed()

func rotate_binded(diff):
	for elem in character.binded_elements:
		elem.rotation -= diff
