extends StaticBody2D


var beams: Dictionary = {}

@onready var light = $Visual/PointLight2D

func set_beam(id, on):
	beams[str(id)] = on

	if beam_count() > 0:
		set_enabled()
	else:
		set_disabled()
	
func clear_beams():
	set_disabled()
	beams = {}

func beam_count():
	var result = 0
	for key in beams.keys():
		if beams[key]:
			result += 1
	return result

func set_enabled():
	light.energy = 1
	light.color = Color("16de2bff")	
	
func set_disabled():
	light.energy = 0.2
	light.color = Color("d36aedff")	
