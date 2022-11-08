extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tower ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Range_body_entered(body: Node) -> void:
	print(body)
	pass # Replace with function body.


func _on_Range_body_exited(body: Node) -> void:
	print(body)
	pass # Replace with function body.
