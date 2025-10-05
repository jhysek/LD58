extends Node2D

func _ready() -> void:
	Transition.openScene()

func _on_start_pressed() -> void:
	if has_node("Sfx"):
		$Sfx/Click.play()
	if has_node("OuterCircle"):
		$OuterCircle/Chevron.lock()
	$Timer.start()

func _process(delta):
	for node in get_tree().get_nodes_in_group("rotate"):
		node.rotation += delta

func _on_timer_timeout() -> void:
	LevelSwitcher.current_level = 0
	LevelSwitcher.start_level()


func _on_back_pressed() -> void:
	if has_node("Sfx"):
		$Sfx/Click.play()
	Transition.switchTo("res://scenes/menu.tscn")
