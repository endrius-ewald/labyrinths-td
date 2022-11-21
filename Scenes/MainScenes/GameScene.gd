extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var level
var can_build # = false
var in_menu = false
var gMap: GridMap
var cam: Camera
var selection_position
var p
var mouse_pos


var build_menu = preload("res://Scenes/UIScenes/BuildMenu.tscn")
var tscn = load("res://Scenes/Towers/Tower.tscn")



onready var selectionTool = $SelectionTool/MeshInstance
onready var ui = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_node("Level")
	gMap = level.get_node("Navigation").get_node("NavigationMeshInstance").get_node("GridMap")
	cam = get_viewport().get_camera()	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	if build_mode:
#		print("Build mode")
		#update_ui()
	pass

func _physics_process(delta: float) -> void:
	if !in_menu:
		mouse_pos = get_viewport().get_mouse_position()
		var from = cam.project_ray_origin(mouse_pos)
		var to = from + cam.project_ray_normal(mouse_pos) * 1000
		
		#funciona apenas com um colider para o mapa
		var space_state = gMap.get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 2) #Colisao na mask2, onde esta o mapColider
		if(result):
			#print ("RESULT : ", result.position)
			p =  gMap.world_to_map(result.position)#point
			var tile = gMap.get_cell_item(p.x, p.y, p.z)
			#print(p)
			#print(tile)
		
			#Verifica se eh possivel construir
			if(tile == 63):#use Set(Conjunto)
				can_build = true
				selectionTool.get_surface_material(0).set_shader_param("color", Color.yellow)
			else:
				can_build = false
				selectionTool.get_surface_material(0).set_shader_param("color", Color.red)	
				#createTower(p.x, p.y, p.z)
				pass
				
			#Move selection tool
			selection_position = gMap.map_to_world(p.x,p.y,p.z)
			selectionTool.translation = selection_position
			selectionTool.translation.y += 0.3 #Faz ficar por cima e nao dentro da tile
			
	if Input.is_action_just_pressed("mouse") and can_build:
		if !in_menu:
			in_menu = true
			var m = build_menu.instance()
			m.rect_position = mouse_pos
			ui.add_child(m)
			#createTower()
		else:
			clean_build_menu()
			in_menu=false
			

func build_tower(arg):
	print("build le tower ", arg)
	match arg:
		0:
			var tower = tscn.instance()
			tower.translation = selection_position
			level.get_node("Navigation").get_node("NavigationMeshInstance").get_node("TowerContainer").add_child(tower)
		1:
			var tower = tscn.instance()
			tower.translation = selection_position
			level.get_node("Navigation").get_node("NavigationMeshInstance").get_node("TowerContainer").add_child(tower)
			
	#Desabilita construção na tile ja construida
	gMap.set_cell_item(p.x,p.y,p.z,-1)
	
	clean_build_menu()
	in_menu = false
	
	var navmesh = level.get_node("Navigation").get_node("NavigationMeshInstance")
	navmesh.bake_navigation_mesh(false)
	
func clean_build_menu():
	ui.get_node("BuildMenu").queue_free()

#func _unhandled_input(event):
#	#print("unhandle_input")
#	if event is InputEventMouseButton and event.is_pressed(): #InputEventScreenTouch
#		print("Input ", event.as_text())
#
#		#manage click 1
#		var from = cam.project_ray_origin(event.position)
#		var to = from + cam.project_ray_normal(event.position) * 1000
#
#		#manage click 2 (works on topcam)
##		var toPos = cam.project_position(event.position, 15) #Camera altitude, funciona pra camera de cima, cam.translation.y
##		print(toPos)
#
#
#		#manage click 3 (1+raycast)
#		#funciona apenas com um colider para o mapa
#		var space_state = gMap.get_world().direct_space_state
#		var result = space_state.intersect_ray(from, to, [], 2) #Colisao na mask2, onde esta o mapColider
#		if(result):
#			print ("RESULT : ", result.position)
#			var p =  gMap.world_to_map(result.position)#point
#
#			print(p)
#			print(gMap.get_cell_item(p.x, p.y, p.z))
#
#			var tile = gMap.get_cell_item(p.x, p.y, p.z)
#			if(tile == 63):#use Set(Conjunto)
#				createTower(p.x, p.y, p.z)
#				pass
#
#			var selection_position = gMap.map_to_world(p.x,p.y,p.z)
#			selection_position.y += 0.3
#			selectionTool.translation = selection_position
		
		
	
func createTower():
	
	var navmesh = level.get_node("Navigation").get_node("NavigationMeshInstance")
	
	var res = ResourceLoader.load("res://Scenes/Towers/Tower.tscn")
	var towerScene: Spatial = res.instance()
	
	towerScene.translation.x = selection_position.x
	towerScene.translation.y = selection_position.y+0.2 #Constroi sobre a tile e nao dentro dela
	towerScene.translation.z = selection_position.z
	
	#REMOVE TILE?
	
	navmesh.get_node("TowerContainer").add_child(towerScene)
	navmesh.bake_navigation_mesh(false)
	
	pass
	
