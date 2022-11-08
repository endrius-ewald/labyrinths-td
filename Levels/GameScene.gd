extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var map
var build_mode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = get_node("Level")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if build_mode:
		print("Build mode")
		#update_ui()
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton: #InputEventScreenTouch
		print("Input ", event.as_text())
		print(get_global_transform_interpolated())
		var gMap: GridMap = map.get_node("Navigation").get_node("NavigationMeshInstance").get_node("GridMap")
		print(gMap)
		#gMap.world_to_map()
	
