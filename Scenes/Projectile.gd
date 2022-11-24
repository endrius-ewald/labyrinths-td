extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target 
var SPEED = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var step_size = delta * SPEED
	
	if target:
		var nextLocation = target.global_transform.origin
		
		#Get direction based on next location
		var direction = global_transform.origin.direction_to(nextLocation)
		
		#Move object
		global_transform.origin += direction * step_size
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_RigidBody_body_entered(body: Node) -> void:
	queue_free()
	pass # Replace with function body.
