extends Node2D

signal on_scene_changed

@onready var source = $Machine/Source

func _ready():
	$Screen.show()
	Transition.openScene()

func _process(delta):
	$TextureRect.rotation += delta * 0.05
	for element in get_tree().get_nodes_in_group("rotate"):
		element.rotate(delta / 2)
	for element in get_tree().get_nodes_in_group("rotate_backwards"):
		element.rotate(-delta / 2)
	
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
	var chevrons = get_tree().get_nodes_in_group("chevron")
	for chevron in chevrons:
		if number > locked:
			locked += 1
			chevron.lock()
		else:
			chevron.unlock()
		
	if locked >= chevrons.size():
		level_finished()
		
func level_finished():
	$Timer.start()

func _on_timer_timeout() -> void:
	LevelSwitcher.next_level()
