extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var level
var build_mode = false
var gMap: GridMap
var cam: Camera


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_node("Level")
	gMap = level.get_node("Navigation").get_node("NavigationMeshInstance").get_node("GridMap")
	cam = get_viewport().get_camera()	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if build_mode:
		print("Build mode")
		#update_ui()
	pass

func _unhandled_input(event):
	#print("unhandle_input")
	if event is InputEventMouseButton and event.is_pressed(): #InputEventScreenTouch
		print("Input ", event.as_text())
		
		#manage click 1
		var from = cam.project_ray_origin(event.position)
		var to = from + cam.project_ray_normal(event.position) * 1000
		print(from)
		print(to)
		
		#manage click 2 (works on topcam)
		var toPos = cam.project_position(event.position, 15) #Camera altitude, funciona pra camera de cima, cam.translation.y
		print(toPos)
		
		
		#manage click 3 (1+raycast)
		#funciona apenas com um colider para o mapa
		var space_state = gMap.get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 1)
		if(result):
			print ("RESULT : ", result.position)
		
		
		print("w2m(1) " , gMap.world_to_map(to))
		print("w2m(2) " , gMap.world_to_map(toPos))
		print("w2m(3) " , gMap.world_to_map(result.position))
		
		print("m2w " , gMap.map_to_world(0,0,-1))
		print("m2w " , gMap.map_to_world(1,0,-1))
		
		
		#construction mechanicas
		var p = gMap.world_to_map(toPos)
		if(gMap.get_cell_item(p.x, p.y, p.z) == 63):
			createTower(p.x, p.y, p.z)
		
		

		

		#print(gMap.get_used_cells())
		#gMap.world_to_map()
	
func createTower(x,y,z):
	
	var navmesh = level.get_node("Navigation").get_node("NavigationMeshInstance")
	
	var res = ResourceLoader.load("res://Scenes/Towers/Tower.tscn")
	var towerScene: Spatial = res.instance()
	
	towerScene.translation.x = x
	towerScene.translation.y = y
	towerScene.translation.z = z
	
	navmesh.add_child(towerScene)
	
	navmesh.bake_navigation_mesh(false)
	
	pass
	
