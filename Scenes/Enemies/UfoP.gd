extends Spatial

#TODO: tunar
var SPEED = 0.5 #5.0
#var path = []
export(NodePath) var alvoPath
onready var alvo : Position3D = get_node(alvoPath)
onready var navigation_agent = $NavigationAgent

signal kamikaze

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	navigation_agent.set_target_location(alvo.global_transform.origin)
	
	#self.connect("kamikaze", "res://Scenes/MainScenes/UI.gd", "lossLife")
	
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
	
	#rotate for animation
	rotate_y(deg2rad(180*delta))
	

func _on_NavigationAgent_target_reached():
	kamikazeee()
	queue_free()
	pass # Replace with function body.

func kamikazeee():
	print("KAMIKAZEE")
	emit_signal("kamikaze")


func _on_RigidBody_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("mouse click ufo")
	pass # Replace with function body.
