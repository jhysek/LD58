extends Node2D

var locked = false

func lock():
	if !locked:
		locked = true
		$AnimationPlayer.play("enable")
		lock_sfx()
		
func unlock():
	if locked:
		locked = false
		$AnimationPlayer.play_backwards("enable")
		$Timer.stop()
		$Sfx/Lock.stop()

func lock_sfx():
	$Timer.start()


func _on_timer_timeout() -> void:
	$Sfx/Lock.play()
