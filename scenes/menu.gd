extends Node2D

func _ready() -> void:
	Transition.openScene()
	show_opened_levels()

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

func show_opened_levels():
	if $CanvasLayer.has_node("Levels"):
		$CanvasLayer/Levels.hide()

		if GlobalState.opened_levels > 0:
			$CanvasLayer/Levels.show()
			for level in $CanvasLayer/Levels/Buttons.get_children():
				if int(level.name) > GlobalState.opened_levels:
					level.disabled = true
					level.modulate = Color("ffffff50")
				else:
					level.modulate = Color("ffffffff")
					level.disabled = false

func openLevel(idx):
	LevelSwitcher.current_level = idx
	LevelSwitcher.start_level()

func _on__pressed() -> void:
	openLevel(0)

func _on_2_pressed() -> void:
	openLevel(1)
	
func _on_3_pressed() -> void:
	openLevel(2)
