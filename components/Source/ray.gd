extends Line2D

const GROUP_BOUNCY = "bouncy"
const GROUP_COLLECTOR = "collector"

@export var cast_length = 600

var max_iterations = 10
var angle = 0
var parent: Node2D
var last_hit = {}

var collector = null

var endpoint = Vector2.ZERO

@onready var space_state = get_world_2d().direct_space_state

func initialize(parent_source, cast_angle_degrees):
	endpoint = parent_source.global_position
	parent = parent_source
	angle = cast_angle_degrees
	clear_points()
	add_point(endpoint)
	
func cast():
	collector = null
	var exclude: Array = []
	
	while max_iterations > 0:
		
		if last_hit.has("collider"):
			exclude = [last_hit.collider]
			print("collider_id: " + str(last_hit.collider_id) + " RID: " + str(last_hit.collider.get_rid()))
			
		var hit = raycast(endpoint, deg_to_rad(angle), exclude)
		
		if hit.is_empty():
			#add_point(endpoint + Vector2.RIGHT.rotated(deg_to_rad(angle)) * cast_length)
			break
			
		add_point(hit.position)
		last_hit = hit
		
		# move endpoint to collision point
		endpoint = hit.position + Vector2.RIGHT.rotated(hit.reflected_angle) * 0.2
		
		if hit.collider.is_in_group(GROUP_COLLECTOR):
			collector = hit.collider
			hit.collider.set_beam(self.get_instance_id(), true)
			
		# if hit to non-bouncy collider, stop bouncing
		if !hit.collider.is_in_group(GROUP_BOUNCY):
			break

		angle = rad_to_deg(hit.reflected_angle)
		
		max_iterations -= 1


func raycast(from_position, angle_radians, excluded_collider_ids):
	var direction = Vector2.RIGHT.rotated(angle_radians)
	var to_position = from_position + direction * cast_length

	print("\nCasting a ray from " + str(from_position) + " to " + str(to_position) + " excluding: " + str(excluded_collider_ids))
	
	var params = PhysicsRayQueryParameters2D.create(from_position, to_position)
	params.exclude = excluded_collider_ids
	var result = space_state.intersect_ray(params)
	
	if result.is_empty():
		return result
		
	print("Result: ", result)
	
	var normal = result.normal
	var reflected_dir = direction.bounce(normal)
	var reflected_angle = reflected_dir.angle()
	result.reflected_angle = reflected_angle
	

	return result
