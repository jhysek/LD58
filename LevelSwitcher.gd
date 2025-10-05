extends Node

var current_level = 0

var levels = [
	"res://levels/level00.tscn",
	"res://levels/level01.tscn",
	"res://levels/level01b.tscn",
	"res://levels/level02.tscn",
	"res://levels/level03.tscn",
	"res://levels/level06.tscn",
	"res://levels/level04.tscn",
	"res://levels/level05.tscn",
	"res://levels/finished.tscn"
]

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_just_released("ui_restart"):
		restart_level()
	if Input.is_action_just_released("ui_cancel"):
		Transition.switchTo("res://scenes/menu.tscn")

	if Input.is_key_pressed(KEY_N) and Input.is_key_pressed(KEY_SHIFT):
		next_level()

func get_current_level():
	return levels[current_level]

func restart_level():
	start_level()

func start_level():
	if GlobalState.opened_levels < current_level + 1:
		GlobalState.opened_levels = current_level + 1
	Transition.switchTo(levels[current_level])

func next_level():
	GlobalState.dragging = false
	current_level += 1

	if current_level < levels.size():
		if GlobalState.opened_levels < current_level + 1:
			GlobalState.opened_levels = current_level + 1
		start_level()
