extends Spatial


var SPEED = 1.0 #5.0
#var path = []
export(NodePath) var alvoPath
onready var alvo : Position3D = get_node(alvoPath)
onready var navigation_agent = $NavigationAgent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	navigation_agent.set_target_location(alvo.global_transform.origin)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# We need to scale the movement speed by how much delta has passed,
	# otherwise the motion won't be smooth.
	var step_size = delta * SPEED
	
	#Get next location
	var nextLocation = navigation_agent.get_next_location()
	
	#Get direction based on next location
	var direction = global_transform.origin.direction_to(nextLocation)
	
	#Move object
	global_transform.origin += direction * step_size  #?navigation_agent.set_velocity(global_transform.origin) for colision avoidence


func _on_NavigationAgent_target_reached():
	queue_free()
	pass # Replace with function body.
