extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target 
var SPEED = 6
var dmg = 40

signal hit(_dmg)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	get_tree().call_group("ememies","recieveDamage",dmg)
#	var list = get_tree().get_nodes_in_group("enemies")
#	for e in list:
#		self.connect("hit",e,"receive_damage")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var step_size = delta * SPEED
	
	if is_instance_valid(target):
		var nextLocation = target.global_translation
		
		#Get direction based on next location
#		var direction = global_transform.origin.direction_to(nextLocation)
		
		#Move object
#		global_transform.origin += direction * step_size
	
		global_transform.origin = global_transform.origin.move_toward(nextLocation, step_size)
	else:
		queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_RigidBody_body_entered(body: Node) -> void:
	queue_free()
	pass # Replace with function body.


func _on_Area_area_entered(area: Area) -> void:
	if(area.collision_layer == 1):
#		get_tree().call_group("enemies","receive_damage",dmg)
		var a = area.get_parent()
		emit_signal("hit",dmg)
		
		queue_free()
	else:
		print("hit something else")
		
	pass # Replace with function body.
