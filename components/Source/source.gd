extends Node2D

var Ray = preload("res://components/Source/ray.tscn")
@export var number_of_rays:int = 6
@export var rotate_speed = 50

@onready var visual = $Visual
@onready var ray_wrapper = $Rays

var rays = []
var source_angle = 0
var target_angle = -1


enum State {
	STILL,
	ROTATING,
	MOVING,
}

var state = State.STILL

func _ready():
	cast_rays()
	
	
func rotate_by(degrees):
	target_angle = source_angle + degrees
	state = State.ROTATING
	
func _physics_process(delta: float) -> void:
	visual.rotate(delta)
	
	match state:
		State.ROTATING:
			if target_angle == -1 || source_angle < target_angle:
				source_angle += delta * rotate_speed
				recast()
			else:
				state = State.STILL
	
func recast():
	for ray in rays:
		ray.queue_free()
	rays = []
	
	cast_rays()
	
func cast_rays():
	var angle_diff = round(360 / number_of_rays)
	
	for number in range(number_of_rays):
		var ray = Ray.instantiate()
		ray_wrapper.add_child(ray)
		ray.initialize(self, source_angle + number * angle_diff)
		ray.cast()
		rays.append(ray)
