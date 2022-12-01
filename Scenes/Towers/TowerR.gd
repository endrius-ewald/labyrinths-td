extends Area

var enemies = []

onready var proj = preload("res://Scenes/Projectile.tscn")
onready var timer = $ShootTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_RedTower_area_entered(area: Area) -> void:
	
	enemies.append(area)
	
	if timer.is_stopped():
		timer.start()

func _on_RedTower_area_exited(area: Area) -> void:
	
	enemies.erase(area)

func _on_ShootTimer_timeout() -> void:
	
	if(enemies.size() > 0):#if there are enemies
		
		var bullet = proj.instance()#instance bullet
		
		bullet.target = enemies[0]#append target
		
		$AudioStreamPlayer.play()#executa o audio do projetil
				
		add_child(bullet)#first add to tree, later transform
		
		bullet.global_transform.origin = global_transform.origin
		bullet.global_transform.origin.y = 1.7
		
	else:#if there are not
		timer.stop()
