extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var enemies = []
var proj = preload("res://Scenes/Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tower readyyy")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
#
#
#func _on_Range_body_entered(body: Node) -> void:
#	enemies.append(body)
#
#	if $ShootTimer.is_stopped():
#		$ShootTimer.start()
#		pass
#	#print(enemies)
#	pass # Replace with function body.
#
#
#func _on_Range_body_exited(body: Node) -> void:
#	enemies.erase(body)
#	#print(enemies)
#	pass # Replace with function body.
#

func _on_NavigationMeshInstance_bake_finished() -> void:
	print("BAKE FINISHED")
	pass # Replace with function body.


func _on_ShootTimer_timeout() -> void:

	if(enemies.size() > 0):
#		$ShootTimer.start()
		
		var bullet = proj.instance()

		#first add later transform
		add_child(bullet)
		
		bullet.global_transform.origin = global_transform.origin
		bullet.global_transform.origin.y = 2
		


		bullet.target = enemies[0]
	else:
		$ShootTimer.stop()
	
	pass # Replace with function body.


func _on_Range_area_entered(area: Area) -> void:
	enemies.append(area)
	
	if $ShootTimer.is_stopped():
		$ShootTimer.start()
		pass
	#print(enemies)
	pass # Replace with function body.


func _on_Range_area_exited(area: Area) -> void:
	enemies.erase(area)
	pass # Replace with function body.
