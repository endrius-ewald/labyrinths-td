extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target 
var SPEED = 10
var dmg = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
