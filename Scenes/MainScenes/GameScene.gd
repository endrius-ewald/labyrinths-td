extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var level
var build_mode = false
var gMap: GridMap
var cam: Camera
onready var selectionTool = $SelectionTool/MeshInstance


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
		
		#manage click 2 (works on topcam)
#		var toPos = cam.project_position(event.position, 15) #Camera altitude, funciona pra camera de cima, cam.translation.y
#		print(toPos)
		
		
		#manage click 3 (1+raycast)
		#funciona apenas com um colider para o mapa
		var space_state = gMap.get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 2) #Colisao na mask2, onde esta o mapColider
		if(result):
			print ("RESULT : ", result.position)
			var p =  gMap.world_to_map(result.position)#point
			
			print(p)
			print(gMap.get_cell_item(p.x, p.y, p.z))
		
			var tile = gMap.get_cell_item(p.x, p.y, p.z)
			if(tile == 63):#use Set(Conjunto)
				createTower(p.x, p.y, p.z)
				pass
				
			var selection_position = gMap.map_to_world(p.x,p.y,p.z)
			selection_position.y += 0.3
			selectionTool.translation = selection_position
		
		
	
func createTower(x,y,z):
	
	var navmesh = level.get_node("Navigation").get_node("NavigationMeshInstance")
	
	var res = ResourceLoader.load("res://Scenes/Towers/Tower.tscn")
	var towerScene: Spatial = res.instance()
	
	towerScene.translation.x = x+0.5
	towerScene.translation.y = y
	towerScene.translation.z = z+0.5
	
	#REMOVE TILE?
	
	navmesh.get_node("TowerContainer").add_child(towerScene)
	navmesh.bake_navigation_mesh(false)
	
	pass
	
