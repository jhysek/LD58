extends Node2D

var locked = false

func lock():
	if !locked:
		locked = true
		$AnimationPlayer.play("enable")
	
func unlock():
	if locked:
		locked = false
		$AnimationPlayer.play_backwards("enable")
