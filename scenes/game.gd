extends Node2D

signal on_scene_changed

@onready var source = $Source

func _ready():
	Transition.openScene()

func _on_button_pressed() -> void:
	$Source.rotate_by(30)
	
func _on_on_scene_changed() -> void:
	var result = 0
	
	for collector in get_tree().get_nodes_in_group("collector"):
		collector.clear_beams()
		
	source.recast()
	
	for collector in get_tree().get_nodes_in_group("collector"):
		result += collector.beam_count()
			
	print("COLLECTED BEAMS: " + str(result))
	
	lock_chevrons(result)

func lock_chevrons(number):
	var locked = 0
	for chevron in get_tree().get_nodes_in_group("chevron"):
		if number > locked:
			locked += 1
			chevron.lock()
		else:
			chevron.unlock()
		
