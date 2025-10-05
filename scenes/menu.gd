extends Node2D

func _ready() -> void:
	Transition.openScene()

func _on_start_pressed() -> void:
	$OuterCircle/Chevron.lock()
	$Timer.start()


func _on_timer_timeout() -> void:
	LevelSwitcher.start_level()
