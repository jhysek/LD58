extends Node

var current_level = 0

var levels = [
	"res://levels/level01.tscn",
	"res://levels/level01b.tscn",
	"res://levels/level02.tscn",
	"res://levels/level03.tscn",
	"res://levels/level05.tscn",
#	"res://levels/level06.tscn",
	"res://levels/finished.tscn"
]

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_just_released("ui_restart"):
		restart_level()

	if Input.is_key_pressed(KEY_N) and Input.is_key_pressed(KEY_SHIFT):
		next_level()

func get_current_level():
	return levels[current_level]

func restart_level():
	start_level()

func start_level():
	Transition.switchTo(levels[current_level])

func next_level():
	print("Next level.... " + str(current_level + 1))
	GlobalState.dragging = false
	print("LEVEL: " + str(current_level) + " DONE")
	current_level += 1

	print("Switching to: " + str(current_level) + " / " + levels[current_level])
	if current_level < levels.size():
		start_level()
