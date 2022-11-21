extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tower readyyy")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Range_body_entered(body: Node) -> void:
	enemies.append(body)
	#print(enemies)
	pass # Replace with function body.


func _on_Range_body_exited(body: Node) -> void:
	enemies.erase(body)
	#print(enemies)
	pass # Replace with function body.


func _on_NavigationMeshInstance_bake_finished() -> void:
	print("BAKE FINISHED")
	pass # Replace with function body.
