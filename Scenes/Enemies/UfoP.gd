extends Spatial

#TODO: tunar
var SPEED = 1 #5.0
var DMG = 1
var LIFE = 100
var value = 100

#var path = []
export(NodePath) var alvoPath
onready var alvo : Position3D = get_node(alvoPath)
onready var navigation_agent = $NavigationAgent

signal kamikaze(dmg)
signal die(money)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	navigation_agent.set_target_location(alvo.global_transform.origin)
	
	rotate_y(deg2rad(randi()%90))
	#4
#	self.connect("kamikaze", "res://Scenes/MainScenes/UI.gd", "lossLife")
	var group = get_tree().get_nodes_in_group("hud")
	self.connect("kamikaze",group[0],"lossLife")
	self.connect("die",group[0],"cashIn")
	
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
#	global_transform.origin.y = .5
	#rotate for animation
	rotate_y(deg2rad(90*delta))
	

func _on_NavigationAgent_target_reached():
	kamikazeee()
	visible = false;
	yield($AudioStreamPlayer2, "finished")
	queue_free()
	pass # Replace with function body.

func kamikazeee():
	#print("KAMIKAZEE")
	#1
	emit_signal("kamikaze",DMG)
	
	$AudioStreamPlayer2.play()
	
	
	#2
	#var group = get_tree().get_nodes_in_group("hud")
	#group[0].lossLife()
	
	#3
	#var hud = get_tree().call_group("hud","lossLife")

func receive_damage(amout):
	LIFE -= amout
	if LIFE <= 0:
		#print("im dead")
		emit_signal("die",value)
		queue_free()
	pass


func _on_RigidBody_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("mouse click ufo ")
	pass # Replace with function body.


func _on_RigidBody_body_entered(body: Node) -> void:
	print("somenting enter rigid body")
	pass # Replace with function body.


func _on_Area_area_entered(area: Area) -> void:
	if area.collision_layer == 8:
		var v = area.get_parent()
		receive_damage(v.dmg)
		#print("hited by ")

		
#	print(area.collision_layer)
		
	pass # Replace with function body.
