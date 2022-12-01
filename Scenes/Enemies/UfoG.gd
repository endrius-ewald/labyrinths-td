extends Area

var SPEED = 1.5 #5.0
var DMG = 1
var LIFE = 100
var value = 150

export(NodePath) var alvoPath
onready var alvo : Position3D = get_node(alvoPath)
onready var navAg = $NavigationAgent

signal kamikaze(dmg)
signal die(money)


func _ready() -> void:
	navAg.set_target_location(alvo.global_transform.origin)#set target 
	
	#Connect to gameLogic in ui
	var group = get_tree().get_nodes_in_group("hud")
	self.connect("kamikaze",group[0],"lossLife")
	self.connect("die",group[0],"cashIn")
	
	rotate_y(deg2rad(randi()%90))#random rotation for animation
	

func _process(delta: float) -> void:
	
	var step_size = delta * SPEED# We need to scale the movement speed by how much delta has passed, otherwise the motion won't be smooth.
	
	#Move object	
	var nextLocation = navAg.get_next_location()#Get next location
	var direction = global_transform.origin.direction_to(nextLocation)#Get direction based on next location
	global_transform.origin += direction * step_size 

	rotate_y(deg2rad(90*delta))#rotate for animation


func _on_NavigationAgent_navigation_finished() -> void:
	#kills itself on the wall
	emit_signal("kamikaze",DMG) #emite sinal para notificar a muralha
	$AudioStreamPlayer2.play() #toca baruhlo da explosao
	visible = false; #retira visibilidade
	yield($AudioStreamPlayer2, "finished") #espera animacao terminar para sair da arvore
	queue_free()
	
	
func receive_damage(amout):
	LIFE -= amout
	if LIFE <= 0:
		emit_signal("die",value)
		queue_free()
		

func _on_UfoGreen_area_entered(area: Area) -> void:
	if area.collision_layer == 8:#just for sure, layer of bullets, not towers
		var v = area.get_parent()
		receive_damage(v.dmg)
		
