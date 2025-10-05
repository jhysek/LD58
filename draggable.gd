class_name Draggable
extends BehaviorResource

var cursor = load("res://assets/cursor-6.png")
var grab = load("res://assets/drag-cursor.png")

@export var max_limit = 100
@export var min_limit = -100
@export var sensitivity = 1.0
@export var direction = Vector2(1, 0) 

var dragging = false

var start_position: Vector2
var line

func on_ready(parent):
	super(parent)
	line = character.line
	
	if line:
		line.global_position = character.global_position
		draw_line()	
	start_position = character.global_position

func draw_line():
	#line.global_position = start_position
	line.points = []
	line.add_point(start_position + direction.normalized() * min_limit - direction.normalized() * character.get_node("Visual").texture.get_width() / 1.1)
	line.add_point(start_position + direction.normalized() * max_limit + direction.normalized() * character.get_node("Visual").texture.get_width() / 1.1)
	
func on_grab_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			GlobalState.set_dragging(true)
			Input.set_custom_mouse_cursor(grab)
		dragging = event.pressed

func on_input(event):
	if event is InputEventMouseButton and !event.pressed:
		print("setting normal cursor")
		Input.set_custom_mouse_cursor(cursor)
		GlobalState.set_dragging(false)
		character.stop_sfx()
		dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = event.relative
		var projected_amount = delta.dot(direction.normalized()) * sensitivity

		var new_position = character.global_position + direction.normalized() * projected_amount
		var offset_vector = new_position - start_position
		var offset_amount = offset_vector.dot(direction.normalized())

		offset_amount = clamp(offset_amount, min_limit, max_limit)

		if abs(offset_amount) > 0:
			print("OFFSET AMOUNT " + str(offset_amount))
			character.play_sfx()
		else:
			character.stop_sfx()
			
		character.global_position = start_position + direction.normalized() * offset_amount
		character.on_changed()
