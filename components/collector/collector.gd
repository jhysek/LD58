extends StaticBody2D


var beams: Dictionary = {}

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
	$Visual/Light.show()
	$Visual/Surface.self_modulate = Color("88ffffff")
	
func set_disabled():
	$Visual/Light.hide()
	$Visual/Surface.self_modulate = Color("ffffff33")
