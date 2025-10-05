extends Node2D

func _ready() -> void:
	Transition.openScene()

func _on_start_pressed() -> void:
	if has_node("OuterCircle"):
		$OuterCircle/Chevron.lock()
	$Timer.start()

func _on_timer_timeout() -> void:
	LevelSwitcher.current_level = 0
	LevelSwitcher.start_level()
