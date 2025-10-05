class_name Behavior
extends CharacterBody2D

var BehaviorResource = load("res://components/behaviors/behavior_resource.gd")
@export var grab: Area2D = null

enum State {
	STATIC,
	PAUSED,
	IDLE,
	DEAD
}

@export var enable_rotation = true
@export var behaviors: Array[BehaviorResource];
@export var state: State = State.IDLE;
@export var binded_elements: Array[CharacterBody2D] = []

@export var rotation_parent: Node2D
@export var tutorial = false

var game
@onready var line = $Line

func _ready():
	game = get_node("/root/Game")
	
	if !grab && has_node("Grab"):
		grab = $Grab
		
	if !enable_rotation:
		$Visual/Grab.queue_free()
		$Visual/Grab2.queue_free()
		
	if tutorial:
		$AnimationPlayer.play("Pulsate")
	for_each_behavior("on_ready", self)


func _process(delta):
	for_each_behavior("on_process", delta)

func _physics_process(delta):
	for_each_behavior("on_physics_process", delta)
	move_and_slide()

func _input(event):
	for_each_behavior("on_input", event)

func for_each_behavior(function_name, argument = null):
	for behavior in behaviors:
		if behavior != null and behavior.has_method(function_name):
			var callable = Callable(behavior, function_name)
			callable.call(argument)

func get_behavior_by_name(resource_name):
	for behavior in behaviors:
		if behavior.resource_name == resource_name:
			return behavior
	return null

func enable_behavior(resource_name):
	var behavior = get_behavior_by_name(resource_name)
	if behavior:
		behavior.enable()

func disable_behavior(resource_name):
	var behavior = get_behavior_by_name(resource_name)
	if behavior:
		behavior.disable()

func on_changed():
	game.emit_signal("on_scene_changed")

func _on_grab_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	for_each_behavior("on_grab_input", event)


func _on_grab_mouse_entered() -> void:
	pass # Replace with function body.


func _on_grab_mouse_exited() -> void:
	pass # Replace with function body.
